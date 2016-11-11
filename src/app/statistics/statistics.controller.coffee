class Statistics extends Controller
  constructor: ($timeout, @AggregatedStatistics, @toastr, @Chat, @$scope, @$log, @$state, @$rootScope) ->
    @chats = @Chat.query(@updateSelectedChat)
    @selectedChatName = 'Select chat...'
    @$scope.selectedChatId = null
    @messages = []
    @isOpen = false

    @$scope.changeChat = @changeChat
    @$scope.loadMore = @loadMore

    todayDateStr = moment().startOf('day').format('YYYY-MM-DD')
    tomorrowDate = moment().endOf('day').format('YYYY-MM-DD')

    @AggregatedStatistics.query({
      chatId: @$state.params.chatId,
      start: todayDateStr + 'T00:00:00Z',
      end: tomorrowDate + 'T23:59:50Z',
      periodLengthInHours: 1
    }, @drawDayStatistics)

    weekStartStr = moment().startOf('week').format('YYYY-MM-DD')
    weekEndStr = moment().endOf('week').format('YYYY-MM-DD')

    @AggregatedStatistics.query({
      chatId: @$state.params.chatId,
      start: weekStartStr + 'T00:00:00Z',
      end: weekEndStr + 'T23:59:50Z',
      periodLengthInHours: 24
    }, @drawWeekStatistics)

    monthStartStr = moment().startOf('month').format('YYYY-MM-DD')
    monthEndStr = moment().endOf('month').format('YYYY-MM-DD')

    @AggregatedStatistics.query({
      chatId: @$state.params.chatId,
      start: monthStartStr + 'T00:00:00Z',
      end: monthEndStr + 'T23:59:50Z',
      periodLengthInHours: (24 * 7)
    }, @drawMonthStatistics)

  selectPercentageTab: (tab, event) =>
    log.info(event)

  drawWeekStatistics: (data) =>
    columns = @convertToColumns(data)
    groups = @convertToDataGroups(data)

    chart = c3.generate({
      bindto: '#week-chart',
      data:
        x: 'x',
        columns: columns,
        type: 'bar',
        groups: [groups]
      axis:
        x:
          type: 'timeseries',
          localtime: true,
          tick:
            format: '%Y-%m-%d'
      bar:
        width:
          ratio: 0.5
    })
    dataset = @calculateUserTotals(data)
    pieChart = c3.generate({
      bindto: '#week-chart-pie'
      data:
        columns: dataset,
        type : 'pie',
    })

  drawMonthStatistics: (data) =>
    columns = @convertToColumns(data)
    groups = @convertToDataGroups(data)

    chart = c3.generate({
      bindto: '#month-chart',
      data:
        x: 'x',
        columns: columns,
        type: 'bar',
        groups: [groups]
      axis:
        x:
          type: 'timeseries',
          localtime: true,
          tick:
            format: '%Y-%m-%d'
      bar:
        width:
          ratio: 0.5
    })
    dataset = @calculateUserTotals(data)
    pieChart = c3.generate({
      bindto: '#month-chart-pie'
      data:
        columns: dataset,
        type : 'pie',
    })

  drawDayStatistics: (data) =>
    @aggregatedStatistics = data

    columns = @convertToColumns(data)
    groups = @convertToDataGroups(data)

    chart = c3.generate({
      bindto: '#day-chart',
      data: {
        x: 'x',
        columns: columns,
        type: 'bar',
        groups: [groups]
      },
      axis: {
        x: {
          type: 'timeseries',
          localtime: true,
          tick: {
            format: '%H:%M:%S'
          }
        }
      },
      bar: {
        width: {
          ratio: 0.5
        }
      }
    })

    dataset = @calculateUserTotals(data)
    pieChart = c3.generate({
      bindto: '#day-chart-pie'
      data:
        columns: dataset,
        type : 'pie',
    })

  calculateUserTotals: (data) ->
    resultMap = {}
    dataset = []
    for period in data.periods
      for user, metric of period.userSpecificMetricsMap
        value = resultMap[user]
        if !value
          value = 0
        resultMap[user] = value + metric.metricsMap.msgCount
    for user, metricValue of resultMap
      dataset.push ([user, metricValue])
    return dataset

  convertToColumns: (data) ->
    columns  = []
    list = ['x']
    columns.push list
    resultMap = {}
    for period in data.periods
      list.push Date.parse(period['periodStart'])
      for user, metric of period.userSpecificMetricsMap
        dataset = resultMap[user]
        if !dataset
          dataset = []
          resultMap[user] = dataset
        dataset.push metric.metricsMap.msgCount
    for user, metricsList of resultMap
      dataset = []
      dataset.push user
      for metric in metricsList
        dataset.push metric
      columns.push dataset
    return columns

  convertToDataGroups: (data) ->
    dataset = {}
    for period in data.periods
      for user, metric of period.userSpecificMetricsMap
        dataset[user] = true
    result = []
    for user, value of dataset
      result.push user
    return result



  open: () =>
    @isOpen = !@isOpen

  updateSelectedChat: (data) =>
    chatId = @$state.params.chatId
    if chatId?
      selectedChat = data.filter((chat) -> chat.id == chatId)[0]
      if (selectedChat?)
        @selectedChat = selectedChat
        @selectedChatName = @selectedChat.name
