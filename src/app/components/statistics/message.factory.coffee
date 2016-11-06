class Message extends Factory
  constructor: ($resource) ->
    return $resource(
      "/api/v1/chats/:chatId/messages/:messageId",
      {
        messageId: '@id'
        chatId: '@chatId'
      }

      'query':
        method: 'GET',
        isArray: false

      'loadMore':
        method: 'GET',
        isArray: false,
        toMessageId: '@toMessageId'
    )

