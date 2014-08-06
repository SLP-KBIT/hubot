# Description:
#   A simple interaction with the built in HTTP Daemon
#
# URLS:
#   /huboco/info
#   /huboco/ping

module.exports = ( robot ) ->
  huboco_info_page =
    """
<!DOCTYPE html>
<html>
  <head>
    <title>Huboco</title>
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" />
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
            <img src="https://raw.githubusercontent.com/hico-horiuchi/huboco/master/icon.png" />
            <h1 class="bold">Huboco</h1>
            <p class="italic">Huboco is Hubot #{robot.version}. She works on laboratory and supports your research activities.</p>
            <p><a class="btn btn-default btn-lg" href="https://github.com/hico-horiuchi/huboco"><i class="fa fa-github"></i>&nbsp;View the GitHub project</a></p>
            <p>&copy; <a class="black" href="https://twitter.com/hico_horiuchi">hico_horiuchi</a></p>
          </div>
        </div>
        <div class="col-md-4"></div>
      </div>
    </div>
  </body>
</html>
    """

  robot.router.get '/huboco/info', ( req, res ) ->
    res.end huboco_info_page

  robot.router.post '/hubot/ping', ( req, res ) ->
    res.end 'PONG'
