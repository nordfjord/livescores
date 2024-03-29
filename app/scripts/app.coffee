'use strict'

angular
  .module('livescoreApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/404',
        templateUrl: '404.html'
      .when '/home',
        templateUrl: 'views/home.html'
        controller: 'HomeCtrl'
      .otherwise
        redirectTo: '/'
