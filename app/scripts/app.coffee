'use strict'

angular
  .module('livescoreApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'ui.select'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/:venue/:lane1/:lane2',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/404',
        templateUrl: '404.html'
      .when '/',
        templateUrl: 'views/home.html'
        controller: 'HomeCtrl'
      .otherwise
        redirectTo: '/404'
