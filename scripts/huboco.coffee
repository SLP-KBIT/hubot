# Description:
#   Show huboco's information.
#
# Commands:
#   hubot hello - Reply suitable greeting to current time.
#   hubot version - Show Hubot version.
#   hubot date - Show current date.
#   hubot time - Show current time.

strftime = require 'strftime'

module.exports = (robot) ->
  robot.respond /hello$/i, ( msg ) ->
    hour = new Date().getHours()

    if 5 <= hour < 11
      msg.reply 'Good morning.'
      return
    if 11 <= hour < 17
      msg.reply 'Hello.'
      return
    if 17 <= hour < 23
      msg.reply 'Good evening.'
      return
    msg.reply 'Good night.'

  robot.respond /version$/i, ( msg ) ->
    msg.reply "I am Hubot version #{robot.version}."

  robot.respond /date$/i, ( msg ) ->
    msg.reply strftime '%Y/%m/%d(%a) %H:%M:%S'

  robot.respond /time$/i, ( msg ) ->
    msg.reply strftime '%H:%M:%S'
