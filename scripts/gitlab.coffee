# Description:
#   Notify GitLab activites by Web hooks.
#
# URLS:
#   /gitlab/hook?room=<room>

url = require( 'url' )
querystring = require( 'querystring' )

state_jpn = ( state ) ->
  switch state
    when 'opened'   then return 'オープン'
    when 'updated'  then return 'アップデート'
    when 'closed'   then return 'クローズ'
    when 'reopened' then return '再オープン'
    when 'merged'   then return 'マージ'

module.exports = ( robot ) ->
  say = ( room, message ) ->
    envelope = room: room
    robot.send envelope, message

  push = ( payload ) ->
    console.log "[#{new Date}] GITLAB PUSH #{payload.repository.name}"
    "#{payload.repository.name} に #{payload.user_name} さんが#{payload.commits.length}件のcommitをpushしました。"
    for commit in payload.commits
      "<#{commit.id[0..6]}> #{commit.message} #{commit.url}"

  issue = ( payload ) ->
    object = payload.object_attributes
    console.log "[#{new Date}] GITLAB ISSUE #{object.state.toUpperCase()}"
    "Issue ##{object.iid} 「#{object.title}」 が#{state_jpn( object.state )}されました。"

  merge_request = ( payload ) ->
    object = payload.object_attributes
    console.log "[#{new Date}] GITLAB MERGE REQUEST #{object.state.toUpperCase()}"
    "MergeRequest ##{object.iid} 「#{object.title}」 が#{state_jpn( object.state )}されました。"

  robot.router.post '/gitlab/hook', ( req, res ) ->
    query   = querystring.parse url.parse( req.url ).query
    room    = query.room
    payload = req.body
    event   = payload.object_kind
    message = ''
    res.send 404 unless room

    switch event
      when 'issue'         then message = issue         payload
      when 'merge_request' then message = merge_request payload
      else                      message = push          payload

    say room, message if message
    res.send 200
