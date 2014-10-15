'use strict'

###*
 # @ngdoc filter
 # @name livescoreApp.filter:propsFilter
 # @function
 # @description
 # # propsFilter
 # Filter in the livescoreApp.
###
angular.module('livescoreApp')
  .filter 'propsFilter', ->
    (items, props) ->
      out = []
      if angular.isArray(items)
        items.forEach (item) ->
          itemMatches = false
          keys = Object.keys(props)
          i = 0

          while i < keys.length
            prop = keys[i]
            text = props[prop].toLowerCase()
            if item[prop].toString().toLowerCase().indexOf(text) isnt -1
              itemMatches = true
              break
            i++
          out.push item  if itemMatches
          return

      else

        # Let the output be the input untouched
        out = items
      out
