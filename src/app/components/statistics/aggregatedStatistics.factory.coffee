class AggregatedStatistics extends Factory
  constructor: ($resource) ->
    return $resource(
      "/api/v1/aggregated-statistics",

      {},

      'query':
        method: 'GET',
        isArray: false,
        start: '@start',
        end: '@end',
        chatId: '@chatId',
        periodLengthInHours: '@periodLengthInHours'

    )
