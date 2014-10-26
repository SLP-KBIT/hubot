# Description:
#   A simple interaction with the built in HTTP Daemon
#
# URLS:
#   /hubot/info
#   /hubot/ping

module.exports = (robot) ->

  robot.router.get '/hubot/info', (req, res) ->
    res.end "hubot page"

  robot.router.post '/hubot/ping', (req, res) ->
    res.end 'PONG'
