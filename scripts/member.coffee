# Description:
#   Show members in Typetalk topic.
#
# Commands:
#   hubot member - Show all members in current topic.
#   hubot member pick - Pick member from current topic.

name = (account) ->
  "@#{account.fullName} #{account.name}"

module.exports = (robot) ->
  topic_members = (topic_id) ->
    url = "https://typetalk.in/api/v1/topics/#{topic_id}/members/status"
    access_token = robot.adapter.bot.accessToken
    header = Authorization: "Bearer #{access_token}"
    received = false

    robot.brain.data.typetalk = {} unless robot.brain.data.typetalk

    timer = setInterval ->
      clearInterval timer if received
      robot.http(url).headers(header).get() (err, res, body) ->
        if res.statusCode is 200
          json = JSON.parse body
          list = []
          for item in json.accounts
            continue if item.account.name is robot.name.toLowerCase()
            list.push item.account
          robot.brain.data.typetalk[topic_id] = list
        else
          robot.brain.data.typetalk[topic_id] = false
        robot.brain.save
      received = true
    , 1000

    robot.brain.data.typetalk[topic_id]

  robot.respond /member$/i, (msg) ->
    topic_id = msg.envelope.room
    members = topic_members topic_id
    unless members
      msg.reply 'Error occurred while getting members.'
      return

    list = (name account for account in members)
    msg.reply '\n```\n' + list.join('\n') + '\n```'

  robot.respond /member\ pick$/i, (msg) ->
    topic_id = msg.envelope.room
    members = topic_members topic_id
    unless members
      msg.reply 'Error occurred while getting members.'
      return

    id = Math.floor(Math.random() * members.length)
    msg.send "@#{members[id].name} Please #{members[id].fullName}."
