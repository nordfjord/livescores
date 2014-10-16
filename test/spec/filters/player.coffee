'use strict'

describe 'Filter: player', ->

  # load the filter's module
  beforeEach module 'livescoreApp'

  # initialize a new instance of the filter before each test
  player = {}
  beforeEach inject ($filter) ->
    player = $filter 'player'

  it 'should return the input prefixed with "player filter:"', ->
    text = 'angularjs'
    expect(player text).toBe ('player filter: ' + text)
