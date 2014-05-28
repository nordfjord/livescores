'use strict'

angular.module('livescoreApp')
  .controller 'MainCtrl', ($scope, $resource, $http, xbowlingApi, $filter) ->
    $scope.venues = [xbowlingApi.venue(5394), xbowlingApi.venue(5395)]

    $scope.lanes = ()->
      venue = $scope.venue
      lanes = [$scope.lane1, $scope.lane2]

