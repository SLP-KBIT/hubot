# Description:
#   Generates help commands for Hubot.
#
# Commands:
#   hubot help - Displays all of the help commands that Hubot knows about.
#   hubot help <query> - Displays all help commands that match <query>.
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.

module.exports = ( robot ) ->
  robot.respond /help\s*(.+)?$/i, ( msg ) ->
    cmds = robot.helpCommands()
    filter = msg.match[1]

    if filter
      cmds = cmds.filter ( cmd ) ->
        cmd.match new RegExp filter, 'i'
      if cmds.length is 0
        msg.reply "No available commands match #{filter}."
        return

    prefix = robot.alias or robot.name
    cmds = cmds.map ( cmd ) ->
      cmd = cmd.replace /^hubot/i, robot.name.toLowerCase()

    msg.reply '\n```\n' + cmds.join('\n') + '\n```'
