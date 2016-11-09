class States extends Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'parent',
        abstract: true
        templateUrl: 'app/statistics/statistics.html'
        controller: 'statisticsController'
        controllerAs: 'statistics'
      .state 'parent.home',
        url: '/'
        parent: 'parent'
    .state 'parent.chat',
      url: '/chat/:chatId'
      parent: 'parent'

