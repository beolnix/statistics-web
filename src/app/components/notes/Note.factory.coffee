class Note extends Factory
  constructor: ($resource) ->
    return $resource('/api/v1/notes/:id', {id: '@id'})
