'use strict'

angular.module('livescoreApp')
.controller 'MainCtrl'
, ($scope, $routeParams, xbowlingApi, $resource, $timeout)->
  $scope.venue = 5395
  $scope.lanes = (()->
    arr = []
    for i in [1..22]
      arr.push []
    arr
  )()



  refresh = ()->
    for i in [1..22]
      do (i)->
        $resource('temp/lane.json').query().$promise.then (data) ->
          $scope.lanes[i-1] = data
#        xbowlingApi.lane($scope.venue, i).$promise.then (data)->
#          $scope.lanes[i-1] = data

    return
  $scope.range = (siz)->
    return [0..siz-1]

  refresh()
#  setInterval(refresh, 7000)

