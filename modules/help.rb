module SerieBot
  module Help
    extend Discordrb::Commands::CommandContainer
    extend Discordrb::EventContainer

    command(:help, description: "Display a list of commands.") do |event|
      text1 = ""
      text1 << "**__Full command list for SerieBot-Git:__**\n"
      text1 << "__Image Commands:__"
      imagecoms = ""
      Commands.image_commands.each { | name, file |
        imagecoms = imagecoms + "`#{Config.prefix}#{name}`, "
      }
      text1 << imagecoms + "\n"

      textcoms = ""
      text1 << "__Text Commands:__"
      Commands.text_commands.each { | name, file |
        textcoms = textcoms + "`#{Config.prefix}#{name}`, "
      }
      text1 << textcoms + "\n"
      event.respond(text1)

      text2 = ""
      text2 << "__Utility Commands__"
      text2 << "`#{Config.prefix}tell`: Send a message to a user via the bot. | Usage: `#{Config.prefix}tell @User\#1234 <Text to send>`"
      text2 << "`#{Config.prefix}avatar`: Display the avatar of a user. | Usage: `#{Config.prefix}avatar @User\#1234`"
      text2 << "`#{Config.prefix}info`: Display various info about a given user. | Usage: `#{Config.prefix}info @User\#1234`"
      text2 << "`#{Config.prefix}qr`: Make a QR Code from the input text/url. | Usage: `#{Config.prefix}qr <text>`"
      text2 << "`#{Config.prefix}say`: Make the bot say something! | Usage: `#{Config.prefix}say <text>`"
      text2 << "\n"

      foldcoms = ""
      text2 << "__Random Image Commands:__"
      Images.folderimage_commands.each {|name, file |
        foldcoms = foldcoms + "`#{Config.prefix}#{name}`, "
      }

      text2 << foldcoms + "\n"
      event.respond(text2)

      text3 = ""
      text3 << "__Moderation Commands__"
      text3 << "The user executing these commands needs the appropriate permission. For example to use `#{Config.prefix}clear`, you need Manage Messages."
      text3 << "`#{Config.prefix}kick`: Temporarily Kick somebody from the server. | Usage: `#{Config.prefix}kick @User\#1234 <reason>`"
      text3 << "`#{Config.prefix}ban`: Permanently Ban somebody from the server. | Usage: `#{Config.prefix}kick @User\#1234 <reason>`"
      text3 << "`#{Config.prefix}clear`: Deletes x messages from the current channel. | Usage: `#{Config.prefix}clear <x>`"
      text3 << "\n"

      text3 << "__Admin Commands__"
      text3 << "Only the Bot Owners may use these commands."
      text3 << "``#{Config.prefix}message`: Sends the result of a Ruby eval as DM. | Usage: `#{Config.prefix}message <ruby code>`"
      text3 << "``#{Config.prefix}game`: Sets the \"Playing\" status of the bot. | Usage: `#{Config.prefix}game <text>`"
      text3 << "``#{Config.prefix}username`: Sets the username of the bot. | Usage: `#{Config.prefix}username <text>`"
      text3 << "``#{Config.prefix}status`: Set the bot as idle or dnd or invisible status. | Usage: `#{Config.prefix}status [idle/dnd/invisible/online]`"
      text3 << "``#{Config.prefix}owner`: Find the Server Owner. Uses current server if no ID is given. | Usage: `#{Config.prefix}owner <ID>`"
      text3 << "``#{Config.prefix}shutdown`: Turns the bot off. | Usage: `#{Config.prefix}shutdown`"
      text3 << "``#{Config.prefix}eval`: Evaluate Ruby code. | Usage: `#{Config.prefix}eval <code>`"
      text3 << "``#{Config.prefix}bash: Evaluate code on the commandline. | Usage: `#{Config.prefix}bash <code>`"
      text3 << "``#{Config.prefix}eval`: Evaluate Ruby code. | Usage: `#{Config.prefix}eval <code>`"
      text3 << "``#{Config.prefix}spam`: Repeat a message a set number of times. | Usage: `#{Config.prefix}spam <num> <text>`"
      text3 << "``#{Config.prefix}upload`: Upload a locally stored file to Discord. | Usage: `#{Config.prefix}upload <filepath>`"
      text3 << "``#{Config.prefix}dump`: Dump and save all messages in a channel. | Usage: `#{Config.prefix}dump <channel_id>`"
      text3 << "``#{Config.prefix}command`: Create a custom command. | Usage: `#{Config.prefix}command [add/remove] <text>`"
      event.respond(text3)
    end

  end
end
