'use strict'

###*
 # @ngdoc function
 # @name livescoreApp.controller:HomeCtrl
 # @description
 # # HomeCtrl
 # Controller of the livescoreApp
###
angular.module('livescoreApp')
.controller 'HomeCtrl',
  ($scope, $location, xbowlingApi, $routeParams, $resource) ->
    $scope.lanes = []
    $scope.manual = !!$routeParams.manual
    dev = !!$routeParams.dev

    $scope.venueChange = ()->
      if dev
        ($resource '/temp/summary.json')
        .query().$promise.then (data)->
          $scope.lanes = data
        return
      if not $scope.manual
        (xbowlingApi.summary $scope.venue)
        .$promise.then (data)->
          $scope.lanes = data
      return
    $scope.venues = [
      {
        name: 'Öskjuhlíð'
        id: '5394'
      }
      {
        name: 'Egilshöll',
        id: '5395'
      }
    ]

    lane = {}

    $scope.goToShow = ()->
      urlstring = "#{$scope.venue}/#{$scope.lane.first}/#{$scope.lane.second}"
      $location.url urlstring
    return
