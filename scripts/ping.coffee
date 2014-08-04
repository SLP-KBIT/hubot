# Description:
#   Ping commands to server.
#
# Commands:
#   huboco ping <ip_address>:<port>

spawn = require( 'child_process' ).spawn

module.exports = ( robot ) ->
  robot.respond /ping\s+(.+)[:|\s+]([0-9]+)$/i, ( msg ) ->
    ip_address = msg.match[1]
    port       = msg.match[2]
    cli_ping   = spawn 'ruby', ['cli/ping.rb', ip_address, port]

    cli_ping.stdout.on 'data', ( data ) ->
      result = String( data ).replace '\n', ''
      console.log "[#{new Date}] PING #{ip_address}:#{port} #{result.toUpperCase()}"

      if result is 'true'
        msg.reply 'ping通りました!'
      else if result is 'false'
        msg.reply 'ping通りませんでした…'

    cli_ping.stderr.on 'data', ( data ) ->
      console.log "[#{new Date}] PING #{ip_address}:#{port} ERROR\n" + data
