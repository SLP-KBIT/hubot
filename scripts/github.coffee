# Description:
#   Notify GitHub activites by Web hooks.
#
# URLS:
#   /github/hook?room=<room>

url = require( 'url' )
querystring = require( 'querystring' )

action_jpn = ( action ) ->
  switch action
    when 'opened'   then return 'オープン'
    when 'closed'   then return 'クローズ'
    when 'reopened' then return '再オープン'
    when 'created'  then return '作成'
    when 'edited'   then return '編集'

module.exports = ( robot ) ->
  say = ( room, message ) ->
    envelope = room: room
    robot.send envelope, message

  commit_comment = ( payload ) ->
    console.log "[#{new Date}] GITHUB COMMIT COMMENT TO #{payload.repository.name} BY #{payload.sender.login}"
    "#{payload.sender.login} さんが #{payload.repository.name} にコメントを書きました。\n#{payload.comment.html_url}"

  gollum = ( payload ) ->
    console.log "[#{new Date}] GITHUB GOLLUM #{payload.repository.name} BY #{payload.sender.login}"
    message = "#{payload.sender.login} さんが #{payload.repository.name} に#{payload.pages.length}件のwikiを更新しました。"
    for page in payload.pages
      message += "\n[#{action_jpn( page.action )}] #{page.page_name} #{page.html_url}"
    message

  issue_comment = ( payload ) ->
    console.log "[#{new Date}] GITHUB ISSUE COMMENT TO #{payload.repository.name} ##{payload.issue.number} BY #{payload.sender.login}"
    "#{payload.sender.login} さんが #{payload.repository.name} のIssue ##{payload.issue.number} にコメントを書きました。\n#{payload.comment.html_url}"

  issues = ( payload ) ->
    switch payload.action
      when 'opened', 'closed', 'reopened'
        console.log "[#{new Date}] GITHUB ISSUE #{payload.action.toUpperCase()} TO #{payload.repository.name} ##{payload.issue.number} BY #{payload.sender.login}"
        "#{payload.sender.login} さんが #{payload.repository.name} のIssue ##{payload.issue.number} 「#{payload.issue.title}」 を#{action_jpn( payload.action )}しました。\n#{payload.issue.html_url}"

  pull_request = ( payload ) ->
    switch payload.action
      when 'opened', 'closed', 'reopened'
        console.log "[#{new Date}] GITHUB PULL REQUEST #{payload.action.toUpperCase()} TO #{payload.repository.name} ##{payload.pull_request.number} BY #{payload.sender.login}"
        "#{payload.sender.login} さんが #{payload.repository.name} のPullRequest ##{payload.pull_request.number} 「#{payload.pull_request.title}」 を#{action_jpn( payload.action )}しました。\n#{payload.pull_request.html_url}"

  pull_request_review_comment = ( payload ) ->
    console.log "[#{new Date}] GITHUB PULL REQUEST COMMENT TO #{payload.repository.name} ##{payload.pull_request.number} BY #{payload.sender.login}"
    "#{payload.sender.login} さんが #{payload.repository.name} のPullRequest ##{payload.pull_request.number} にコメントを書きました。\n#{payload.comment.html_url}"

  push = ( payload ) ->
    console.log "[#{new Date}] GITHUB PUSH TO #{payload.repository.name} BY #{payload.pusher.name}"
    message = "#{payload.pusher.name} さんが #{payload.repository.name} に#{payload.commits.length}件のcommitをpushしました。"
    for commit in payload.commits
      message += "\n<#{commit.id[0..6]}> #{commit.message}"
    message += "\n#{payload.compare}"
    message

  robot.router.post '/github/hook', ( req, res ) ->
    query   = querystring.parse url.parse( req.url ).query
    room    = query.room
    event   = req.headers['x-github-event']
    payload = req.body
    message = ''
    res.send 404 unless room

    switch event
      when 'commit_comment'              then message = commit_comment              payload
      when 'gollum'                      then message = gollum                      payload
      when 'issue_comment'               then message = issue_comment               payload
      when 'issues'                      then message = issues                      payload
      when 'pull_request'                then message = pull_request                payload
      when 'pull_request_review_comment' then message = pull_request_review_comment payload
      when 'push'                        then message = push                        payload

    say room, message if message
    res.send 200
