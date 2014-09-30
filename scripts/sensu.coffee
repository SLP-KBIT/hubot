# Description:
#   Notify Sensu alerts.
#
# URLS:
#   /sensu?room=<room>

url = require 'url'
querystring = require 'querystring'

module.exports = (robot) ->
  say = (room, message) ->
    envelope = room: room
    robot.send envelope, '[Sensu] ' + message

  robot.router.post '/sensu', (req, res) ->
    query = querystring.parse url.parse(req.url).query
    room = query.room
    payload = req.body
    res.send 400 unless room

    if payload.occurrences is 1 and payload.check.status > 0
      msg = "Alert of #{payload.check.name} occuerrd"
      msg += " in #{payload.client.name}.\n"
      msg += "```\n#{payload.check.output}\n```"
      say room, msg

    res.send 200
