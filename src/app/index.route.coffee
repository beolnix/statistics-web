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
      .state 'about',
        url: '/about'
        templateUrl: 'app/about/about.html'
        controller: 'aboutController'
        controllerAs: 'about'


