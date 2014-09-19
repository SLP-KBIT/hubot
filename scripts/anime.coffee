# Description:
#   Show anime list from ANIMEMAP.
#
# Commands:
#   hubot anime - Show animes that being broadcast.
#   hubot anime today - Show animes that broadcasting today.
#   hubot anime search <title> - Show animes that match <title>.

strftime = require 'strftime'

anime = (item, with_day = false) ->
  msg = "#{item['time']} #{item['title']} #{item['next']}"
  msg = "#{item['week']} " + msg if with_day
  msg

module.exports = (robot) ->
  location = process.env.HUBOT_ANIME_LOCATION or 'tokyo'

  animemap = ->
    url = "http://animemap.net/api/table/#{location}.json"
    received = false

    timer = setInterval ->
      clearInterval timer if received
      robot.http(url).get() (err, res, body) ->
        if res.statusCode is 200
          json = JSON.parse body
          robot.brain.data.anime = json.response.item
        else
          robot.brain.data.anime = false
        robot.brain.save
      received = true
    , 1000

    robot.brain.data.anime

  robot.respond /anime$/i, (msg) ->
    animes = animemap()
    unless animes
      msg.reply 'Error occurred while getting from ANIMEMAP.'
      return

    list = (anime item, true for item in animes)
    if list.length is 0
      msg.reply 'No result.'
      return
    msg.reply '\n' + list.join '\n'

  robot.respond /anime\s+today$/i, (msg) ->
    animes = animemap()
    unless animes
      msg.reply 'Error occurred while getting from ANIMEMAP.'
      return

    list = (anime item for item in animes when item['today'] is '1')
    if list.length is 0
      msg.reply 'No result.'
      return
    msg.reply '\n' + list.join '\n'

  robot.respond /anime\s+search\s+(.+)$/i, (msg) ->
    keyword = msg.match[1]
    animes = animemap()
    unless animes
      msg.reply 'Error occurred while getting from ANIMEMAP.'
      return

    regex = new RegExp keyword, 'i'
    list = (anime item for item in animes when item['title'].search(regex) >= 0)
    if list.length is 0
      msg.reply 'No result.'
      return
    msg.reply '\n' + list.join '\n'
