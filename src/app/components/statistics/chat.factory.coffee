class Chat extends Factory
  constructor: ($resource) ->
    return $resource('/api/v1/chats/:id', {id: '@id'})
