class Statistics extends Controller
  constructor: ($timeout, @AggregatedStatistics, @toastr, @Chat, @$scope, @$log, @$state, @$rootScope) ->
    @chats = @Chat.query(@updateSelectedChat)
    @selectedChatName = 'Select chat...'
    @$scope.selectedChatId = null
    @messages = []
    @isOpen = false

    @$scope.changeChat = @changeChat
    @$scope.loadMore = @loadMore

    todayDateStr = new Date().toISOString().slice(0,10);
    tomorrowDate = new Date(new Date().getTime() + 24 * 60 * 60 * 1000).toISOString().slice(0,10);

    @AggregatedStatistics.query({
      chatId: @$state.params.chatId,
      start: todayDateStr + 'T00:00:00Z',
      end: tomorrowDate + 'T00:00:00Z',
      periodLengthInHours: 1
    }, @updateStatistics)


  updateStatistics: (data) =>
    @aggregatedStatistics = data
    @$log.info("received statistics: " + @aggregatedStatistics)

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

    test = []

    chart = c3.generate({
      bindto: '#chart',
      data: {
        x: 'x',
        columns: columns,
        type: 'bar',
        groups: [
          ['data1', 'data2', 'data3']
        ]
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

    test


  open: () =>
    @isOpen = !@isOpen

  updateSelectedChat: (data) =>
    chatId = @$state.params.chatId
    if chatId?
      selectedChat = data.filter((chat) -> chat.id == chatId)[0]
      if (selectedChat?)
        @selectedChat = selectedChat
        @selectedChatName = @selectedChat.name
