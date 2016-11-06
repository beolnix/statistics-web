class Chat extends Controller
  constructor: ($timeout, @toastr, @Chat, @Message, @$scope, @$log, @$state, @$rootScope) ->
    @messages = []
    @$rootScope.$on('statistics.loadMore', @loadMore)
    @$rootScope.$on('statistics.note.reloadMessages', @updateMessages)
    @updateMessages()

  updateMessages: () =>
    chatId = @$state.params.chatId
    if chatId?
      @$scope.selectedChatId = chatId
      @toastr.info("selected chat: " + chatId)
      @requestMessages(chatId)

  requestMessages: (chatId) =>
    @Message.query({chatId: chatId}, @showMessages)

  showMessages: (data, responseHeaders) =>
    if (data.content.length > 0)
      @messages = data.content
      for message in @messages
        message.formatted = @getFormattedDate(message.timestamp)

  loadMore:() =>
    last = @messages[-1..][0]
    @Message.loadMore({chatId: @$scope.selectedChatId, toMessageId: last.id}, @appendMessages)

  appendMessages:(data, responseHeaders) =>
    newMessages = data.content
    for message in newMessages
      message.formatted = @getFormattedDate(message.timestamp)
    @messages = @messages.concat newMessages


  selectMessage: (msg, type, $event) =>
    msgId = msg.id
    elem = $event.currentTarget
    active = elem.getAttribute("class").indexOf("active") > -1
    if active
      newClassAttr = elem.getAttribute("class").replace("btn-default", "")
      if "question" == type
        newClassAttr = newClassAttr + " btn-warning"
      else
        newClassAttr = newClassAttr + " btn-primary"
      elem.setAttribute("class", newClassAttr)
      @addMessage(msg, type)
      @removeMessage(msg, @oppositeType(type))
    else
      newClassAttr = elem.getAttribute("class")
        .replace("btn-warning", "")
        .replace("btn-primary", "") + " btn-default"
      elem.setAttribute("class", newClassAttr)
      @removeMessage(msg, type)
    @switchToDefault($event.currentTarget, type)



  switchToDefault: (elem, type) =>
    if "question" == type
      def = elem.parentElement.children[1]
      newClassAttr = def.getAttribute("class")
      .replace("btn-warning", "")
      .replace("btn-primary", "") + " btn-default"
      def.setAttribute("class", newClassAttr)
    else
      def = elem.parentElement.children[0]
      newClassAttr = def.getAttribute("class")
        .replace("btn-warning", "")
        .replace("btn-primary", "") + " btn-default"
      def.setAttribute("class", newClassAttr)


  oppositeType: (type) =>
    if "question" == type
      return "answer"
    else
      return "question"

  removeMessage: (msg, type) =>
    @$rootScope.$emit('chat.removeMessageFromNote', {
      msg: msg
      type: type
    })

  addMessage: (msg, type) =>
    @$rootScope.$emit('chat.addMessageToNote', {
      msg: msg
      type: type
    })

  getFormattedDate: (timestamp) ->
    d = new Date(timestamp)
    return d.getDate()  + "." + (d.getMonth()+1) + "." + d.getFullYear() + " " +
        d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds()




