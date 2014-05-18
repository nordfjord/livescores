'use strict'

describe 'Directive: bowlFrame', ->

  # load the directive's module
  beforeEach module 'livescoreApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<bowl-frame></bowl-frame>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the bowlFrame directive'
