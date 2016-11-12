module SerieBot
  module Help
    extend Discordrb::Commands::CommandContainer
    extend Discordrb::EventContainer

    command(:help, description: "Display a list of commands.") do |event|
      event << "**__Full command list for SerieBot-Git:__**\n"
      event << "__Image Commands:__"
      imagecoms = ""
      Commands.image_commands.each { | name, file |
        imagecoms = imagecoms + "`#{Config.prefix}#{name}`, "
      }
      event << imagecoms + "\n"

      text coms = ""
      event << "__Text Commands:__"
      Commands.text_commands.each { | name, file |
        textcoms = textcoms + "`#{Config.prefix}#{name}`, "
      }
      event << textcoms + "\n"

      event << "__Utility Commands__"
      event << "`#{Config.prefix}tell`: Send a message to a user via the bot. | Usage: `#{Config.prefix}tell @User\#1234 <Text to send>`"
      event << "`#{Config.prefix}avatar`: Display the avatar of a user. | Usage: `#{Config.prefix}avatar @User\#1234`"
      event << "`#{Config.prefix}info`: Display various info about a given user. | Usage: `#{Config.prefix}info @User\#1234`"
      event << "`#{Config.prefix}qr`: Make a QR Code from the input text/url. | Usage: `#{Config.prefix}qr <text>`"
      event << "`#{Config.prefix}say`: Make the bot say something! | Usage: `#{Config.prefix}say <text>`"
      event << "\n"

      folcoms = ""
      event << "__Random Image Commands:__"
      Images.folderimage_commands.each {|name, file |
        foldcoms = foldcoms + "`#{Config.prefix}#{name}`, "
      }

      event << foldcoms + "\n"

      event << "__Moderation Commands__"
      event << "The user executing these commands needs the appropriate permission. For example to use `#{Config.prefix}clear`, you need Manage Messages."
      event << "`#{Config.prefix}kick`: Temporarily Kick somebody from the server. | Usage: `#{Config.prefix}kick @User\#1234 <reason>`"
      event << "`#{Config.prefix}ban`: Permanently Ban somebody from the server. | Usage: `#{Config.prefix}kick @User\#1234 <reason>`"
      event << "`#{Config.prefix}clear`: Deletes x messages from the current channel. | Usage: `#{Config.prefix}clear <x>`"
      event << "\n"

      event << "__Admin Commands__"
      event << "Only the Bot Owners may use these commands."
      event << "``#{Config.prefix}message`: Sends the result of a Ruby eval as DM. | Usage: `#{Config.prefix}message <ruby code>`"
      event << "``#{Config.prefix}game`: Sets the \"Playing\" status of the bot. | Usage: `#{Config.prefix}game <text>`"
      event << "``#{Config.prefix}username`: Sets the username of the bot. | Usage: `#{Config.prefix}username <text>`"
      event << "``#{Config.prefix}status`: Set the bot as idle or dnd or invisible status. | Usage: `#{Config.prefix}status [idle/dnd/invisible/online]`"
      event << "``#{Config.prefix}owner`: Find the Server Owner. Uses current server if no ID is given. | Usage: `#{Config.prefix}owner <ID>`"
      event << "``#{Config.prefix}shutdown`: Turns the bot off. | Usage: `#{Config.prefix}shutdown`"
      event << "``#{Config.prefix}eval`: Evaluate Ruby code. | Usage: `#{Config.prefix}eval <code>`"
      event << "``#{Config.prefix}bash: Evaluate code on the commandline. | Usage: `#{Config.prefix}bash <code>`"
      event << "``#{Config.prefix}eval`: Evaluate Ruby code. | Usage: `#{Config.prefix}eval <code>`"
      event << "``#{Config.prefix}spam`: Repeat a message a set number of times. | Usage: `#{Config.prefix}spam <num> <text>`"
      event << "``#{Config.prefix}upload`: Upload a locally stored file to Discord. | Usage: `#{Config.prefix}upload <filepath>`"
      event << "``#{Config.prefix}dump`: Dump and save all messages in a channel. | Usage: `#{Config.prefix}dump <channel_id>`"
      event << "``#{Config.prefix}command`: Create a custom command. | Usage: `#{Config.prefix}command [add/remove] <text>`"
    end

  end
end
