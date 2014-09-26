# Description:
#   Invite member to Typetalk topic.
#
# URLS:
#   /typetalk/form?topic_id=<topic_id>
#   /typetalk/invite

request = require 'request'
url = require 'url'
querystring = require 'querystring'

module.exports = (robot) ->
  form_page = (topic_id) ->
    """
<!DOCTYPE html>
<html>
  <head>
    <title>Huboco</title>
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/lumen/bootstrap.min.css" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Exo:400,400italic,800" rel="stylesheet" />
    <style type="text/css"><!--
      body, h1, h2, h3, h4, text {
        font-family: 'Exo', sans-serif;
        font-weight: 400;
      }
      .bold { font-weight: 800; }
      .italic{ font-style: italic; }
      .main {
        text-align: center;
        margin: 50px 0;
      }
      a.black { color: #333333; }
      a.black:hover {
        color: #999999;
        text-decoration: none;
      }
      @media screen and (max-width: 970px) {
        .main { margin: 15px 0; }
      }
    --></style>
  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4 main">
          <div class="well">
            <img src="http://nulab-inc.com/assets/img/home/img_apps_typetalk@2x.png" />
            <h1 class="bold">Typetalk</h1>
            <p class="italic">I invite you to Typetalk Topic #{topic_id}.</p>
            <form action="/typetalk/invite" method="post">
              <input type="hidden" name="topic_id" value="#{topic_id}">
              <div class="form-group">
                <div class="input-group">
                  <span class="input-group-addon"><i class="fa fa-envelope fa-fw"></i></span>
                  <input type="text" class="form-control" name="mail_address" placeholder="Your mail address...">
                  <span class="input-group-btn">
                    <button class="btn btn-default" type="submit"><i class="fa fa-send fa-fw"></i></button>
                  </span>
                </div>
              </div>
            </form>
            <p>&copy; <a class="black" href="https://twitter.com/hico_horiuchi">hico_horiuchi</a></p>
          </div>
        </div>
        <div class="col-md-4"></div>
      </div>
    </div>
  </body>
</html>
    """

  submit_page = (mail_address) ->
    """
<!DOCTYPE html>
<html>
  <head>
    <title>Huboco</title>
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/lumen/bootstrap.min.css" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Exo:400,400italic,800" rel="stylesheet" />
    <style type="text/css"><!--
      body, h1, h2, h3, h4, text {
        font-family: 'Exo', sans-serif;
        font-weight: 400;
      }
      .bold { font-weight: 800; }
      .italic{ font-style: italic; }
      .main {
        text-align: center;
        margin: 50px 0;
      }
      a.black { color: #333333; }
      a.black:hover {
        color: #999999;
        text-decoration: none;
      }
      @media screen and (max-width: 970px) {
        .main { margin: 15px 0; }
      }
    --></style>
  </head>
  <body>
    <div class="container">
      <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4 main">
          <div class="well">
            <h1><i class="fa fa-send fa-5x"></i></h1>
            <br />
            <p class="italic">I send to #{mail_address} the invitation mail.</p>
            <p>&copy; <a class="black" href="https://twitter.com/hico_horiuchi">hico_horiuchi</a></p>
          </div>
        </div>
        <div class="col-md-4"></div>
      </div>
    </div>
  </body>
</html>
    """

  say = (room, message) ->
    envelope = room: room
    robot.send envelope, message

  invite_member = (topic_id, mail_address) ->
    access_token = robot.adapter.bot.accessToken
    options =
      url: "https://typetalk.in/api/v1/topics/#{topic_id}/members/invite"
      form:
        'inviteMembers[0]': mail_address
        'inviteMessage': ''
      headers:
        'Authorization': "Bearer #{access_token}"

    request.post options, (err, res, body) ->
      if res.statusCode is 200
        say parseInt(topic_id), "Invited #{mail_address.match(/(.+)@.+/)[1]}."

  robot.router.get '/typetalk/form', (req, res) ->
    query    = querystring.parse url.parse(req.url).query
    topic_id = query.topic_id
    unless topic_id
      res.send 400
      return
    res.end form_page(topic_id)

  robot.router.post '/typetalk/invite', (req, res) ->
    payload = req.body
    unless payload.mail_address
      res.send 400
      return
    invite_member payload.topic_id, payload.mail_address
    res.end submit_page(payload.mail_address)
