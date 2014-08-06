# Description:
#   Invite member to Typetalk topic.
#
# URLS:
#   /typetalk/form
#   /typetalk/invite

request = require 'request'

module.exports = ( robot ) ->
  typetalk_form_page = ( topic_id ) ->
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
              <input type="hidden" name="topicId" value="#{topic_id}">
              <div class="form-group">
                <div class="input-group">
                  <span class="input-group-addon"><i class="fa fa-envelope fa-fw"></i></span>
                  <input type="text" class="form-control" name="mailAddress" placeholder="Your mail address...">
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

  typetalk_submit_page = ( mail_address ) ->
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

  invite_member = ( topic_id, mail_address ) ->
    access_token = robot.adapter.bot.accessToken
    options =
      url: "https://typetalk.in/api/v1/topics/#{topic_id}/members/invite"
      form:
        'inviteMembers[0]': mail_address,
        'inviteMessage': ''
      headers:
        'Authorization': "Bearer #{access_token}"

    request.post options, ( err, res, body ) =>
      if res.statusCode isnt 200
        console.log "[#{new Date}] #{res.statusCode} MISS INVITE #{mail_address} TO #{topic_id}"
      else
        console.log "[#{new Date}] INVITE #{mail_address} TO #{topic_id}"

  robot.router.get '/typetalk/form', ( req, res ) ->
    rooms = process.env.HUBOT_TYPETALK_ROOMS.split ','
    res.end typetalk_form_page( rooms[0] )

  robot.router.post '/typetalk/invite', ( req, res ) ->
    payload = req.body
    invite_member payload.topicId, payload.mailAddress
    res.send typetalk_submit_page( payload.mailAddress )
