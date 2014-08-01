# Description:
#   Show anime list from ANIMEMAP.
#
# Commands:
#   huboco anime
#   huboco anime today
#   huboco anime search <title>

module.exports = ( robot ) ->
  location = process.env.HUBOT_ANIME_LOCATION or 'tokyo'

  get_animemap = ->
    d     = new Date
    year  = d.getFullYear()
    month = d.getMonth() + 1; month = "0#{month}" if month < 10
    day   = d.getDate()     ; day   = "0#{day}"   if day   < 10
    date  = parseInt( "#{year}#{month}#{day}" )

    robot.brain.data.anime = {} if not robot.brain.data.anime
    robot.brain.data.anime[location] = {} if not robot.brain.data.anime[location]
    if not robot.brain.data.anime[location]['date'] or robot.brain.data.anime[location]['date'] < date
      url = "http://animemap.net/api/table/#{location}.json"
      robot.http( url ).get() ( err, res, body ) ->
        if res.statusCode isnt 200
          console.log "[#{d}] ANIME NO RESULT #{location}"
          msg.reply 'アニメの情報を取得できませんでした…'
          robot.brain.data.anime[location]['date'] = false
          robot.brain.data.anime[location]['list'] = false
        else
          json = JSON.parse body
          robot.brain.data.anime[location]['date'] = date
          robot.brain.data.anime[location]['list'] = json.response.item
        robot.brain.save

    robot.brain.data.anime[location]['list']

  robot.respond /anime$/i, ( msg ) ->
    animes = get_animemap()
    if animes
      list = []
      console.log "[#{new Date}] ANIME #{location}"
      for item in animes
        list.push "#{item['week']} #{item['time']}～ #{item['title']} 第#{item['next']}"
      if list.length is 0
        msg.reply '今期、放送中のアニメはありません。'
      else
        msg.reply "今期、放送中のアニメは、\n#{list.join '\n'}"

  robot.respond /anime\s+today$/i, ( msg ) ->
    animes = get_animemap()
    if animes
      list = []
      console.log "[#{new Date}] ANIME #{location} TODAY"
      for item in animes
        if item['today'] is '1'
          list.push "#{item['time']}～ #{item['title']} 第#{item['next']}"
      if list.length is 0
        msg.reply '今日、放送のアニメはありません。'
      else
        msg.reply "今日、放送のアニメは、\n#{list.join '\n'}"

  robot.respond /anime\s+search\s+(.+)$/i, ( msg ) ->
    keyword = msg.match[1]
    animes  = get_animemap()
    if animes
      list = []
      regex = new RegExp keyword, 'i'
      console.log "[#{new Date}] ANIME #{location} SEARCH #{keyword}"
      for item in animes
        if item['title'].search( regex ) >= 0
          list.push "#{item['week']} #{item['time']}～ #{item['title']} 第#{item['next']}"
      if list.length is 0
        msg.reply '検索にヒットするアニメはありません。'
      else
        msg.reply "検索にヒットしたアニメは、\n#{list.join '\n'}"
