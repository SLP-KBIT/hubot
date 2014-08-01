# Description:
#   Generates help commands for Hubot.

module.exports = ( robot ) ->
  robot.respond /help\s*(.+)?$/i, ( msg ) ->
    cmds   = robot.helpCommands()
    filter = msg.match[1]

    if filter
      cmds = cmds.filter ( cmd ) ->
        cmd.match new RegExp( filter, 'i' )
      if cmds.length == 0
        console.log( "[#{new Date}] HELP NOT MATCH #{filter}" )
        msg.reply "#{filter}ってコマンドはありませんよ!"
        return
      else
        console.log( "[#{new Date}] HELP FILTER #{filter}" )
    else
      console.log( "[#{new Date}] HELP " )

    prefix = robot.alias or robot.name
    cmds = cmds.map ( cmd ) ->
      cmd = cmd.replace /hubot/ig, robot.name
      cmd.replace new RegExp( "^#{robot.name}" ), prefix

    msg.reply "\n#{cmds.join '\n'}"
