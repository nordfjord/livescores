'use strict'

angular.module('livescoreApp')
  .directive('kliBowlFrame', ->
    templateUrl: 'views/klibowlframe.html'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the bowlFrame directive'
  )
