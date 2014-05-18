'use strict'

angular.module('livescoreApp')
	.controller 'MainCtrl', ($scope, $resource, $http) ->
		$scope.bowls = []
		$http.get('temp/bowl.json')
		.success (data)->
			console.log(data)
			$scope.bowls = data
