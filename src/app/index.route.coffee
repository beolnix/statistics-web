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
        views:
          chatView:
            templateUrl: 'app/statistics/chat.html',
            controller: 'chatController',
            controllerAs: 'chatController'
    .state 'parent.chat',
      url: '/chat/:chatId'
      parent: 'parent'
      views:
        chatView:
          templateUrl: 'app/statistics/chat.html',
          controller: 'chatController',
          controllerAs: 'chatController'
