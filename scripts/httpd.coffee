# Description:
#   A simple interaction with the built in HTTP Daemon
#
# URLS:
#   /huboco/info
#   /huboco/ping

huboco_info_page = ->
  """
<!DOCTYPE html>
<html>
  <head>
    <title>Huboco</title>
    <meta content="width=device-width, initial-scale=1" name="viewport" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Exo:400,800" rel="stylesheet" />
    <style type="text/css"><!--
      body, h1, h2, h3, h4, text {
        font-family: 'Exo', sans-serif;
        font-weight: 400;
      }
      .bold {
        font-family: 'Exo', sans-serif;
        font-weight: 800;
      }
      .main {
        text-align: center;
        margin: 50px 0;
      }
    --></style>
  </head>
  <body>
    <div class="container main">
      <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4">
          <div class="well">
            <img src="https://raw.githubusercontent.com/hico-horiuchi/huboco/master/icon.png" />
            <h1 class="bold">Huboco is working !</h1>
            <a class="btn btn-default btn-lg" href="https://github.com/hico_horiuchi/huboco">
              <i class="fa fa-github-alt"></i>&nbsp;View the GitHub project
            </a>
          </div>
        </div>
        <div class="col-md-4"></div>
      </div>
    </div>
  </body>
</html>
  """

module.exports = ( robot ) ->
  robot.router.get "/huboco/info", ( req, res ) ->
    res.end huboco_info_page()

  robot.router.post "/huboco/ping", ( req, res ) ->
    res.end "PONG"
