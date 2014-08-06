# Description:
#   Show members in Typetalk topic.
#
# Commands:
#   huboco member
#   huboco who

module.exports = ( robot ) ->
  get_topic_members = ( topic_id ) ->
    url          = "https://typetalk.in/api/v1/topics/#{topic_id}/members/status"
    access_token = robot.adapter.bot.accessToken
    received     = false
    header       = Authorization: "Bearer #{access_token}"

    robot.brain.data.typetalk         = {} if not robot.brain.data.typetalk
    robot.brain.data.typetalk.members = {} if not robot.brain.data.typetalk.members

    timer = setInterval ->
      clearInterval timer if received
      robot.http( url ).headers( header ).get() ( err, res, body ) =>
        if res.statusCode isnt 200
          console.log "[#{d}] MEMBERS NO RESULT #{topic_id}"
          msg.reply 'メンバーの情報を取得できませんでした…'
          robot.brain.data.typetalk.members[topic_id] = false
        else
          json = JSON.parse body
          list = []
          for account in json.accounts
            continue if account.account.name is robot.name.toLowerCase()
            list.push account.account
          robot.brain.data.typetalk.members[topic_id] = list
        robot.brain.save
        received = true
    , 1000

    robot.brain.data.typetalk.members[topic_id]

  robot.respond /member$/i, ( msg ) ->
    topic_id = msg.envelope.room
    members  = get_topic_members topic_id
    if members
      list = []
      console.log "[#{new Date}] MEMBER #{topic_id}"
      for account in members
        list.push "#{account.name} さん"
      msg.reply "このトピックのメンバーは、\n#{list.join 'と\n'}\nです。"

  robot.respond /who$/i, ( msg ) ->
    topic_id = msg.envelope.room
    members  = get_topic_members topic_id
    if members
      id = Math.floor( Math.random() * members.length )
      console.log "[#{new Date}] WHO #{topic_id}"
      msg.send "@#{members[id].name} さん、お願いします!"
