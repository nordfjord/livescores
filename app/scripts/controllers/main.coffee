'use strict'

angular.module('livescoreApp')
  .controller 'MainCtrl', ($scope, $routeParams, xbowlingApi, $resource) ->
    venue = $routeParams.venue
    $scope.venue = venue
    $scope.venue = 5394 if venue is 'oskjuhlid'
    $scope.venue = 5395 if venue is 'egilsholl'
    $scope.lane1 = parseInt($routeParams.lane1)
    $scope.lane2 = parseInt($routeParams.lane2)
    $scope.dev = !!$routeParams.dev
    $scope.lanes = [[],[]]

    findBootstrapEnvironment = ()->
      envs = ['xs', 'sm', 'md', 'lg']

      $el = $('<div>')
      $el.appendTo($('body'))

      for i in [envs.length-1..0] by -1
        env = envs[i]

        $el.addClass('hidden-'+env)
        if ($el.is(':hidden'))
          $el.remove()
          return env

    $scope.env = findBootstrapEnvironment()
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

    getNewestFrame = (lane)->
      index = 0
      return index if not lane[0]
      for i in [1..10] by 1
        if lane[0]["frameScore#{i}"] == ""
          return i - 2

    $scope.range = (lane)->
      sizes = 'lg': 10, 'md': 10, 'sm': 4, 'xs': 2
      size = sizes[$scope.env]
      newestFrame = getNewestFrame(lane)
      newestFrame = size if(newestFrame < size)
      firstframe = newestFrame - size + 1
      retarr = [firstframe..newestFrame]
      retarr
    $scope.total = (index, lane)->
      frameTotal = 0
      angular.forEach lane, (value)->
        frameTotal += parseInt value["frameScore#{index}"] or 0
      frameTotal
    refresh()
    setInterval(refresh, 7000)

