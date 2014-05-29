'use strict'

describe 'Service: xbowlingApi', ->

  # load the service's module
  beforeEach module 'livescoreApp'

  # instantiate service
  xbowlingApi = {}
  beforeEach inject (_xbowlingApi_) ->
    xbowlingApi = _xbowlingApi_

  it 'should do something', ->
    expect(!!xbowlingApi).toBe true
