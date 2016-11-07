class Statistics extends Controller
  constructor: ($timeout, @AggregatedStatistics, @toastr, @Chat, @$scope, @$log, @$state, @$rootScope) ->
    @chats = @Chat.query(@updateSelectedChat)
    @selectedChatName = 'Select chat...'
    @$scope.selectedChatId = null
    @messages = []
    @isOpen = false

    @$scope.changeChat = @changeChat
    @$scope.loadMore = @loadMore

    @AggregatedStatistics.query({
      chatId: @$state.params.chatId,
      start: '2016-11-04T15:53:00Z',
      end: '2016-11-11T15:53:00Z',
      periodLengthInHours: 2
    }, @updateStatistics)


  updateStatistics: (data) =>
    @aggregatedStatistics = data
    @$log.info("received statistics: " + @aggregatedStatistics)

  open: () =>
    @isOpen = !@isOpen

  updateSelectedChat: (data) =>
    chatId = @$state.params.chatId
    if chatId?
      selectedChat = data.filter((chat) -> chat.id == chatId)[0]
      if (selectedChat?)
        @selectedChat = selectedChat
        @selectedChatName = @selectedChat.name
