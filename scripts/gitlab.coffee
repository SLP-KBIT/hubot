# Description:
#   Notify GitLab activites by Web hooks.
#
# URLS:
#   /gitlab/hook

state_jpn = ( state ) ->
  switch state
    when 'opened'   then return 'オープン'
    when 'updated'  then return 'アップデート'
    when 'closed'   then return 'クローズ'
    when 'reopened' then return '再オープン'
    when 'merged'   then return 'マージ'

module.exports = ( robot ) ->
  say = ( message ) ->
    rooms    = process.env.HUBOT_TYPETALK_ROOMS.split ','
    envelope = room: rooms[0]
    robot.send envelope, message

  push = ( payload ) ->
    console.log "[#{new Date}] GITLAB PUSH #{payload.repository.name}"
    say "#{payload.repository.name} に #{payload.user_name} さんが#{payload.commits.length}件のcommitをpushしました。"
    for commit in payload.commits
      say "<#{commit.id[0..6]}> #{commit.message}"

  issue = ( payload ) ->
    object = payload.object_attributes
    console.log "[#{new Date}] GITLAB ISSUE #{object.state.toUpperCase()}"
    say "Issue ##{object.iid} 「#{object.title}」 が#{state_jpn( object.state )}されました。"

  merge_request = ( payload ) ->
    object = payload.object_attributes
    console.log "[#{new Date}] GITLAB MERGE REQUEST #{object.state.toUpperCase()}"
    say "MergeRequest ##{object.iid} 「#{object.title}」 が#{state_jpn( object.state )}されました。"

  robot.router.post '/gitlab/hook', ( req, res ) ->
    payload = req.body
    event   = payload.object_kind

    switch event
      when 'issue'         then issue         payload
      when 'merge_request' then merge_request payload
      else                      push          payload

    res.send 200
