'use strict'

###*
 # @ngdoc filter
 # @name livescoreApp.filter:player
 # @function
 # @description
 # # player
 # Should Filter Lanes based on players on that lane
###
angular.module('livescoreApp')
  .filter 'player', ->
    (input) ->
      'player filter: ' + input
