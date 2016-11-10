class States extends Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/about'

    $stateProvider
      .state 'parent',
        abstract: true
        templateUrl: 'app/statistics/statistics.html'
        controller: 'statisticsController'
        controllerAs: 'statistics'
      .state 'about',
        url: '/about'
        templateUrl: 'app/about/about.html'
        controller: 'aboutController'
        controllerAs: 'about'
      .state 'parent.chat',
        url: '/chat/:chatId'
        parent: 'parent'


