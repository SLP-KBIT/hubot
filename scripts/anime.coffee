# Description:
#   Show anime list from ANIMEMAP.
#
# Commands:
#   huboco anime
#   huboco anime today
#   huboco anime search <title>

module.exports = ( robot ) ->
  location = process.env.HUBOT_ANIME_LOCATION or 'tokyo'
  url      = "http://animemap.net/api/table/#{location}.json"
  request  = robot.http( url ).get()

  animemap_no_result = ( msg ) ->
    console.log( "[#{new Date}] ANIME NO RESULT #{location}" )
    msg.reply 'アニメの情報を取得できませんでした…'

  robot.respond /anime$/i, ( msg ) ->
    request ( err, res, body ) ->
      if res.statusCode isnt 200
        animemap_no_result( msg ); return
      json = JSON.parse body
      list = []
      console.log( "[#{new Date}] ANIME #{location}" )
      for item in json.response.item
        list.push( "#{item['week']} #{item['time']}～ #{item['title']} 第#{item['next']}" )
      if list.length is 0
        msg.reply '今期、放送中のアニメはありません。'
      else
        msg.reply "今期、放送中のアニメは、\n#{list.join '\n'}"

  robot.respond /anime\s+today$/i, ( msg ) ->
    request ( err, res, body ) ->
      if res.statusCode isnt 200
        animemap_no_result( msg ); return
      json = JSON.parse body
      list = []
      console.log( "[#{new Date}] ANIME #{location} TODAY" )
      for item in json.response.item
        if item['today'] is '1'
          list.push( "#{item['time']}～ #{item['title']} 第#{item['next']}" )
      if list.length is 0
        msg.reply '今日、放送のアニメはありません。'
      else
        msg.reply "今日、放送のアニメは、\n#{list.join '\n'}"

  robot.respond /anime\s+search\s+(.+)$/i, ( msg ) ->
    keyword = msg.match[1]
    request ( err, res, body ) ->
      if res.statusCode isnt 200
        animemap_no_result( msg ); return
      console.log( "[#{new Date}] ANIME #{location} SEARCH #{keyword}" )
      json  = JSON.parse body
      list  = []
      regex = new RegExp( keyword, 'i' )
      for item in json.response.item
        if item['title'].search( regex ) >= 0
          list.push( "#{item['week']} #{item['time']}～ #{item['title']} 第#{item['next']}" )
      if list.length is 0
        msg.reply '検索にヒットするアニメはありません。'
      else
        msg.reply "検索にヒットしたアニメは、\n#{list.join '\n'}"
