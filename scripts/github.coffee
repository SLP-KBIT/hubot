# Description:
#   Notify GitHub activites by Web hooks.
#
# URLS:
#   /github/hook?room=<room>

url = require 'url'
querystring = require 'querystring'

commit_comment = (p) ->
  msg = "#{p.sender.login} commented to #{p.repository.name}.\n"
  msg += p.comment.html_url

gollum = (p) ->
  msg = "#{p.sender.login} changed #{p.pages.length} pages "
  msg += "of #{p.repository.name} Wiki."
  for page in p.pages
    msg += "\n[#{action_jpn(page.action)}] #{page.page_name} #{page.html_url}"
  msg

issue_comment = (p) ->
  msg = "#{p.sender.login} commented to Issue ##{p.issue.number} "
  msg += "of #{p.repository.name}.\n#{p.comment.html_url}"

issues = (p) ->
  if p.action.indexOf ['opened', 'closed', 'reopened']
    msg = "#{p.sender.login} #{p.action} Issue ##{p.issue.number} "
    msg += "'#{p.issue.title}'\n.#{p.issue.html_url}"

pull_request = (p) ->
  if p.action.indexOf ['opened', 'closed', 'reopened']
    msg = "#{p.sender.login} #{p.action} PullRequest ##{p.pull_request.number} "
    msg += "'#{p.pull_request.title}'\n.#{p.pull_request.html_url}"

pull_request_review_comment = (p) ->
  msg = "#{p.sender.login} commented to PullRequest ##{p.pull_request.number} "
  msg += "of #{p.repository.name}.\n#{p.comment.html_url}"

push = (p) ->
  msg = "#{p.pusher.name} pushed #{p.commits.length} commits "
  msg += "to #{p.repository.name}."
  for commit in p.commits
    msg += "\n<#{commit.id[0..6]}> #{commit.message}"
  msg += "\n#{p.compare}"

module.exports = (robot) ->
  say = (room, message) ->
    envelope = room: room
    robot.send envelope, '[GitHub] ' + message

  robot.router.post '/github/hook', (req, res) ->
    event = req.headers['x-github-event']
    payload = req.body
    query = querystring.parse url.parse(req.url).query
    room = query.room
    res.send 404 unless room

    switch event
      when 'commit_comment'
        say room, commit_comment(payload)
      when 'gollum'
        say room, gollum(payload)
      when 'issue_comment'
        say room, issue_comment(payload)
      when 'issues'
        say room, issues(payload)
      when 'pull_request'
        say room, pull_request(payload)
      when 'pull_request_review_comment'
        say room, pull_request_review_comment(payload)
      when 'push'
        say room, push(payload)

    res.send 200
