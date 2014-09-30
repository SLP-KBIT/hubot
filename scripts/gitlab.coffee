# Description:
#   Notify GitLab activites by Web hooks.
#
# URLS:
#   /gitlab/hook?room=<room>

url = require 'url'
querystring = require 'querystring'

capitalize = (text) ->
  text.charAt(0).toUpperCase() + text.slice(1)

push = (payload) ->
  msg = "#{payload.user_name} pushed #{payload.commits.length} commits "
  msg += "#{payload.repository.name}.\n```"
  for commit in payload.commits
    msg += "\n<#{commit.id[0..6]}> #{commit.message} #{commit.url}"
  msg += '\n```'

issue = (payload) ->
  object = payload.object_attributes
  msg = "#{capitalize object.state} Issue ##{object.iid} "
  msg += "'#{object.title}'.\n#{object.url}"

merge_request = (payload) ->
  object = payload.object_attributes
  msg = "#{capitalize object.state} MergeRequest ##{object.iid} "
  msg += "'#{object.title}'.\n"

module.exports = (robot) ->
  say = (room, message) ->
    envelope = room: room
    robot.send envelope, '[GitLab] ' + message

  robot.router.post '/gitlab/hook', (req, res) ->
    query   = querystring.parse url.parse(req.url).query
    room = query.room
    payload = req.body
    event = payload.object_kind
    res.send 400 unless room

    switch event
      when 'issue'
        say room, issue(payload)
      when 'merge_request'
        say room, merge_request(payload)
      else
        say room, push(payload)

    res.send 200
