# Description:
#   Notify Sensu alerts.
#
# URLS:
#   /sensu?room=<room>

url = require( 'url' )
querystring = require( 'querystring' )

module.exports = ( robot ) ->
  say = ( room, message ) ->
    envelope = room: room
    robot.send envelope, message

  robot.router.post '/sensu', ( req, res ) ->
    query   = querystring.parse url.parse( req.url ).query
    room    = query.room
    payload = req.body
    message = ''
    res.send 404 unless room

    if payload.occurrences is 1
      console.log "[#{new Date}] SENSU #{payload.client.name} #{payload.check.name}"
      message = "#{payload.client.name} で #{payload.check.name} のアラートが発生しました!\n#{payload.check.output}"
      say room, message if message

    res.send 200
