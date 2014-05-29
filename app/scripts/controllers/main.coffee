'use strict'

angular.module('livescoreApp')
  .controller 'MainCtrl', ($scope, $routeParams, xbowlingApi, $resource) ->
    venue = $routeParams.venue
    $scope.venue = venue
    $scope.venue = 5394 if venue is 'oskjuhlid'
    $scope.venue = 5395 if venue is 'egilsholl'
    $scope.lane1 = parseInt($routeParams.lane1)
    $scope.lane2 = parseInt($routeParams.lane2)
    $scope.dev = true if $routeParams.lane2 is 'dev'
    $scope.lanes = [[],[]]
    refresh = ()->
      if not $scope.dev
        xbowlingApi.lane($scope.venue, $scope.lane1).$promise.then (data)->
          $scope.lanes[0] = data
          return
        xbowlingApi.lane($scope.venue, $scope.lane2).$promise.then (data)->
          $scope.lanes[1] = data
          return
      else
        ($resource '/temp/lane.json')
        .query().$promise.then (data)->
          $scope.lanes[1] = data
          $scope.lanes[0] = data
          return
      return
    $scope.range = (n)->
      return new Array(n)
    $scope.total = (index, lane)->
      frameTotal = 0
      angular.forEach lane, (value)->
        frameTotal += parseInt value["frameScore#{index}"] or 0
      return frameTotal
    refresh()
#    setInterval(refresh, 7000)
