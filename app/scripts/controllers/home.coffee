'use strict'

###*
 # @ngdoc function
 # @name livescoreApp.controller:HomeCtrl
 # @description
 # # HomeCtrl
 # Controller of the livescoreApp
###
angular.module('livescoreApp')
  .controller 'HomeCtrl', ($scope, $location) ->
    $scope.venues = [{name: 'Öskjuhlíð', id: '5394'},{name: 'Egilshöll',id: '5395'}]

    $scope.goToShow = ()->
      urlstring = "#{$scope.venue}/#{$scope.lane.first}/#{$scope.lane.second}"
      console.log "changing url to: #{urlstring}"
      $location.url urlstring
