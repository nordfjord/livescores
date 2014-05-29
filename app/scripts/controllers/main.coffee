'use strict'

angular.module('livescoreApp')
  .controller 'MainCtrl', ($scope, $routeParams, xbowlingApi) ->
    venue = $routeParams.venue
    $scope.venue = 5394 if venue is 'oskjuhlid'
    $scope.venue = 5395 if venue is 'egilsholl'
    $scope.lane1 = parseInt($routeParams.lane1)
    $scope.lane2 = parseInt($routeParams.lane2)
    $scope.lanes = [[],[]]
    refresh = ()->
      xbowlingApi.lane($scope.venue, $scope.lane1).$promise.then (data)->
        $scope.lanes[0] = data
        return
      xbowlingApi.lane($scope.venue, $scope.lane2).$promise.then (data)->
        $scope.lanes[1] = data
        return
      return
    $scope.range = (n)->
      return new Array(n)
    refresh()
    setInterval(refresh, 7000)
