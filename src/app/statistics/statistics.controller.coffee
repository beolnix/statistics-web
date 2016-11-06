class Statistics extends Controller
  constructor: ($timeout, @toastr, @Chat, @Message, @$scope, @$log, @$state, @$rootScope) ->
    @chats = @Chat.query(@updateSelectedChat)
    @selectedChatName = 'Select chat...'
    @$scope.selectedChatId = null
    @messages = []
    @isOpen = false

    @$scope.changeChat = @changeChat
    @$scope.loadMore = @loadMore

  updateSelectedChat: (data) =>
    chatId = @$state.params.chatId
    if chatId?
      selectedChat = data.filter((chat) -> chat.id == chatId)[0]
      if (selectedChat?)
        @selectedChat = selectedChat
        @selectedChatName = @selectedChat.name

  loadMore:() =>
    @$rootScope.$emit('history.loadMore')




