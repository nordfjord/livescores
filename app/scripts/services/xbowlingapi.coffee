'use strict'

angular.module('livescoreApp')
  .factory 'xbowlingApi', ($resource)->
    xbowlingApiRoot = "http://api.xbowling.com"
    scoreTimoutMinutes = 90
    formatDateTimeForRequest = (toFormat)->
      year = toFormat.getUTCFullYear()
      month = toFormat.getUTCMonth() + 1
      date = toFormat.getUTCDate()
      hours = toFormat.getUTCHours()
      minutes = toFormat.getUTCMinutes()
      seconds = toFormat.getUTCSeconds()
      "#{year}/#{month}/#{date} #{hours}:#{minutes}:#{seconds}"

    return {
      venue: (id)->
        ($resource "#{xbowlingApiRoot}/venue/:id").get(id:id)
      lane: (id, number)->
        to = new Date()
        from = new Date((do to.getTime) - scoreTimoutMinutes * 60000)
        ($resource "#{xbowlingApiRoot}/venue/:id/lane/:number").query
          id: id
          number: number
          from: formatDateTimeForRequest(from)
          to: formatDateTimeForRequest(to)
    }
