# Description:
#   Show huboco's information.
#
# Commands:
#   huboco hello
#   huboco version
#   huboco date
#   huboco time

get_date = ->
  d = new Date
  days = ['日', '月', '火', '水', '木', '金', '土']
  date = []

  date['year']  = d.getFullYear()
  date['month'] = d.getMonth() + 1
  date['date']  = d.getDate()
  date['hour']  = d.getHours()
  date['min']   = d.getMinutes()
  date['sec']   = d.getSeconds()
  date['day']   = days[d.getDay()]

  date

module.exports = (robot) ->
  robot.hear /^@huboco hello$/i, ( msg ) ->
    hour = new Date().getHours()

    if 5 <= hour and hour < 11
      answer = ['GOOD MORNING', 'おはようございます。']
    else if 11 <= hour and hour < 17
      answer = ['HELLO', 'こんにちは。']
    else if 17 <= hour and hour < 23
      answer = ['GOOD EVENING', 'こんばんは。']
    else
      answer = ['GOOD NIGHT', 'おやすみなさい。']

    console.log( "[#{new Date}] #{answer[0]}" )
    msg.reply answer[1]

  robot.hear /^@huboco version$/i, ( msg ) ->
    version = robot.version
    console.log( "[#{new Date}] VERSION #{version}" )
    msg.reply "#{version}です。"

  robot.hear /^@huboco date$/i, ( msg ) ->
    console.log( "[#{new Date}] DATE" )
    date = get_date()

    str =  "#{date['year']}年#{date['month']}月#{date['date']}日(#{date['day']}) "
    str += "#{date['hour']}時#{date['min']}分#{date['sec']}秒です。"
    msg.reply str

  robot.hear /^@huboco time$/i, ( msg ) ->
    console.log( "[#{new Date}] TIME" )
    date = get_date()

    str = "#{date['hour']}時#{date['min']}分#{date['sec']}秒です。"
    msg.reply str
