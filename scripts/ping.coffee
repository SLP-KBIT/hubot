# Description:
#   Ping commands to server.
#
# Commands:
#   huboco ping <ip_address>:<port>

spawn = require( 'child_process' ).spawn

module.exports = ( robot ) ->
  robot.hear /^huboco ping (.+):([0-9]+)$/i, ( msg ) ->
    ip_address = msg.match[1]
    port       = msg.match[2]

    cli_ping = spawn( 'ruby', ['cli/ping.rb', ip_address, port] )
    cli_ping.stdout.on 'data', ( data ) ->
      result = String( data )
      if result is 'true\n'
        msg.send 'ping通りました(≧▽≦)'
      else if result is 'false\n'
        msg.send 'ping通りませんでした(＞＿＜)'
    cli_ping.stderr.on 'data', ( data ) ->
      console.log( 'cli_ruby stderr: ' + data )
