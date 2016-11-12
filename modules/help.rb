module SerieBot
  module Help
    extend Discordrb::Commands::CommandContainer
    extend Discordrb::EventContainer

    command(:help, description: "Display a list of commands.") do |event|
      event.channel.start_typing
      text1 = ""
      text1 << "**__Full command list for SerieBot-Git:__**\n\n"
      text1 << "__Image Commands:__\n\n"
      imagecoms = ""
      Commands.image_commands.each { | name, file |
        imagecoms = imagecoms + "`#{Config.prefix}#{name}`, "
      }
      text1 << imagecoms + "\n"

      textcoms = ""
      text1 << "__Text Commands:__\n"
      Commands.text_commands.each { | name, file |
        textcoms = textcoms + "`#{Config.prefix}#{name}`, "
      }
      text1 << textcoms + "\n\n"
      event.user.pm(text1)

      text2 = ""
      text2 << "__Utility Commands__\n"
      text2 << "`#{Config.prefix}tell`: Send a message to a user via the bot. | Usage: `#{Config.prefix}tell @User\#1234 <Text to send>`\n"
      text2 << "`#{Config.prefix}avatar`: Display the avatar of a user. | Usage: `#{Config.prefix}avatar @User\#1234`\n"
      text2 << "`#{Config.prefix}info`: Display various info about a given user. | Usage: `#{Config.prefix}info @User\#1234`\n"
      text2 << "`#{Config.prefix}qr`: Make a QR Code from the input text/url. | Usage: `#{Config.prefix}qr <text>`\n"
      text2 << "`#{Config.prefix}say`: Make the bot say something! | Usage: `#{Config.prefix}say <text>`\n"
      text2 << "\n"

      foldcoms = ""
      text2 << "__Random Image Commands:__\n"
      Images.folderimage_commands.each {|name, file |
        foldcoms = foldcoms + "`#{Config.prefix}#{name}`, "
      }

      text2 << foldcoms + "\n\n"
      event.user.pm(text2)

      text3 = ""
      text3 << "__Moderation Commands__\n"
      text3 << "The user executing these commands needs the appropriate permission. For example to use `#{Config.prefix}clear`, you need Manage Messages.\n"
      text3 << "`#{Config.prefix}kick`: Temporarily Kick somebody from the server. | Usage: `#{Config.prefix}kick @User\#1234 <reason>`\n"
      text3 << "`#{Config.prefix}ban`: Permanently Ban somebody from the server. | Usage: `#{Config.prefix}kick @User\#1234 <reason>`\n"
      text3 << "`#{Config.prefix}clear`: Deletes x messages from the current channel. | Usage: `#{Config.prefix}clear <x>`\n"
      text3 << "\n"

      text3 << "__Admin Commands__\n"
      text3 << "Only the Bot Owners may use these commands.\n"
      text3 << "`#{Config.prefix}message`: Sends the result of a Ruby eval as DM. | Usage: `#{Config.prefix}message <ruby code>`\n"
      text3 << "`#{Config.prefix}game`: Sets the \"Playing\" status of the bot. | Usage: `#{Config.prefix}game <text>`\n"
      text3 << "`#{Config.prefix}username`: Sets the username of the bot. | Usage: `#{Config.prefix}username <text>`\n"
      text3 << "`#{Config.prefix}status`: Set the bot as idle or dnd or invisible status. | Usage: `#{Config.prefix}status [idle/dnd/invisible/online]`\n"
      text3 << "`#{Config.prefix}owner`: Find the Server Owner. Uses current server if no ID is given. | Usage: `#{Config.prefix}owner <ID>`\n"
      text3 << "`#{Config.prefix}shutdown`: Turns the bot off. | Usage: `#{Config.prefix}shutdown`\n"
      text3 << "`#{Config.prefix}eval`: Evaluate Ruby code. | Usage: `#{Config.prefix}eval <code>`\n"
      text3 << "`#{Config.prefix}bash: Evaluate code on the commandline. | Usage: `#{Config.prefix}bash <code>`\n"
      text3 << "`#{Config.prefix}eval`: Evaluate Ruby code. | Usage: `#{Config.prefix}eval <code>`\n"
      text3 << "`#{Config.prefix}spam`: Repeat a message a set number of times. | Usage: `#{Config.prefix}spam <num> <text>`\n"
      text3 << "`#{Config.prefix}upload`: Upload a locally stored file to Discord. | Usage: `#{Config.prefix}upload <filepath>`\n"
      text3 << "`#{Config.prefix}dump`: Dump and save all messages in a channel. | Usage: `#{Config.prefix}dump <channel_id>`\n"
      text3 << "`#{Config.prefix}command`: Create a custom command. | Usage: `#{Config.prefix}command [add/remove] <text>`\n"
      event.user.pm(text3)
      event.respond(":white_check_mark: I've DMed you the command list!")
    end

  end
end
