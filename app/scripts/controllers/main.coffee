'use strict'

angular.module('livescoreApp')
  .controller 'MainCtrl', ($scope, $routeParams, xbowlingApi, $resource, $timeout) ->
    $scope.venue = 5395
    $scope.lanes = []



    refresh = ()->
      newData = []
      for i in [1..22]
        xbowlingApi.lane($scope.venue, i).$promise.then (data)->
          newData.push data
      $timeout(()->
        $scope.lanes = newData
      , 5000)

      return
    $scope.range = (siz)->
      return [0..siz-1]

    refresh()
    setInterval(refresh, 7000)

