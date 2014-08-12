# Description:
#   Notify GitHub activites by Web hooks.
#
# URLS:
#   /github/hook

action_jpn = ( action ) ->
  switch action
    when 'opened'   then return 'オープン'
    when 'closed'   then return 'クローズ'
    when 'reopened' then return '再オープン'

module.exports = ( robot ) ->
  say = ( message ) ->
    rooms    = process.env.HUBOT_TYPETALK_ROOMS.split ','
    envelope = room: rooms[0]
    robot.send envelope, message

  commit_comment = ( payload ) ->
    console.log "[#{new Date}] GITHUB COMMIT COMMENT TO #{payload.repository.name} BY #{payload.sender.login}"
    say "#{payload.sender.login} さんが #{payload.repository.name} にコメントを書きました。\n#{payload.comment.html_url}"

  issue_comment = ( payload ) ->
    console.log "[#{new Date}] GITHUB ISSUE COMMENT TO #{payload.repository.name} ##{payload.issue.number} BY #{payload.sender.login}"
    say "#{payload.sender.login} さんが #{payload.repository.name} のIssue ##{payload.issue.number} にコメントを書きました。\n#{payload.comment.html_url}"

  issues = ( payload ) ->
    switch payload.action
      when 'opened', 'closed', 'reopened'
        console.log "[#{new Date}] GITHUB ISSUE #{payload.action.toUpperCase()} TO #{payload.repository.name} ##{payload.issue.number} BY #{payload.sender.login}"
        say "#{payload.sender.login} さんが #{payload.repository.name} のIssue ##{payload.issue.number} 「#{payload.issue.title}」 を#{action_jpn( payload.action )}しました。\n#{payload.issue.html_url}"

  pull_request = ( payload ) ->
    switch payload.action
      when 'opened', 'closed', 'reopened'
        console.log "[#{new Date}] GITHUB PULL REQUEST #{payload.action.toUpperCase()} TO #{payload.repository.name} ##{payload.pull_request.number} BY #{payload.sender.login}"
        say "#{payload.sender.login} さんが #{payload.repository.name} のPullRequest ##{payload.pull_request.number} 「#{payload.pull_request.title}」 を#{action_jpn( payload.action )}しました。\n#{payload.pull_request.html_url}"

  pull_request_review_comment = ( payload ) ->
    console.log "[#{new Date}] GITHUB PULL REQUEST COMMENT TO #{payload.repository.name} ##{payload.pull_request.number} BY #{payload.sender.login}"
    say "#{payload.sender.login} さんが #{payload.repository.name} のPullRequest ##{payload.pull_request.number} にコメントを書きました。\n#{payload.comment.html_url}"

  push = ( payload ) ->
    console.log "[#{new Date}] GITHUB PUSH TO #{payload.repository.name} BY #{payload.pusher.name}"
    message = "#{payload.pusher.name} さんが #{payload.repository.name} に#{payload.commits.length}件のcommitをpushしました。"
    for commit in payload.commits
      message += "\n<#{commit.id[0..6]}> #{commit.message}"
    message += "\n#{payload.compare}"
    say message

  robot.router.post '/github/hook', ( req, res ) ->
    event   = req.headers['x-github-event']
    payload = req.body

    switch event
      when 'commit_comment'              then commit_comment              payload
      when 'issue_comment'               then issue_comment               payload
      when 'issues'                      then issues                      payload
      when 'pull_request'                then pull_request                payload
      when 'pull_request_review_comment' then pull_request_review_comment payload
      when 'push'                        then push                        payload

    res.send 200
