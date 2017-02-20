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
      # Remove ", " to create full list
      text1 << imagecoms[0...-2] + ".\n"

      textcoms = ""
      text1 << "__Text Commands:__\n"
      Commands.text_commands.each { | name, file |
        textcoms = textcoms + "`#{Config.prefix}#{name}`, "
      }
      # Remove ", " to create full list
      text1 << textcoms[0...-2] + ".\n\n"
      event.user.pm(text1)

      text2 = ""
      text2 << "__Utility Commands:__\n\n"
      text2 << "`#{Config.prefix}tell @user <text>`: Send a message to a user via the bot.\n"
      text2 << "`#{Config.prefix}avatar @user`: Display the avatar of the given user\n"
      text2 << "`#{Config.prefix}info @user`: Display various info about the specified user.\n"
      text2 << "`#{Config.prefix}qr <text>`: Make a QR Code from the input text/url.\n"
      text2 << "`#{Config.prefix}say <text>`: Make the bot say the specified text.\n"
      text2 << "\n"

      foldcoms = ""
      text2 << "__Random Image Commands:__\n\n"
      Images.folderimage_commands.each {|name, file |
        foldcoms = foldcoms + "`#{Config.prefix}#{name}`, "
        text2 << imagecoms
      }

      # Remove ", " to create full list
      text2 << foldcoms[0...-2] + ".\n\n"
      event.user.pm(text2)

      if Config.yuu_commands
        text3 = ''
        text3 << "__Food Commands:__\n\n"
        # To preserve readability, we'll split the following list across multiple lines.
        text3 << '`potato`, `cake`, `cookie`, `biscuit`, `sandwich`, `taco`, `coffee`, `noodles`, `muffin`, `tea`,'
        text3 << '`keto`, `beer`, `cheese`, `pancake`, `chicken`, `nugget`, `pie`, `icecream`, `brekkie`, `doobie`,'
        text3 << "`pizza`, `chocolate`, `pasta`, `cereal`.\n"

        text3 << "__Attack Commands:__\n\n"
        text3 << "`#{Config.prefix}lart @user`: LARTs the given user\n"
        text3 << "`#{Config.prefix}slap @user`: Makes the bot slap the given user.\n"
        text3 << "`#{Config.prefix}compliment @user`: Makes the bot compliment the given user.\n"
        text3 << "`#{Config.prefix}strax @user`: Strax quote.\n"
        text3 << "`#{Config.prefix}nk @user`: Outputs a random North Korea propaganda slogan.\n"
        text3 << "`#{Config.prefix}insult @user`: insults the given user\n"
        text3 << "`#{Config.prefix}present @user`: gives gift to the given user\n"
        text3 << "\n"

        text3 << "__Other Commands:__\n\n"
        text3 << '`wouldyourather`, `fact`, `eightball`, `vote`, `topicchange`, `fortune`, `factdiscord`, `cats`, `catgifs`,'
        text3 << '`flip`, `fight`, `choose`, `coin`.'
        event.user.pm(text3)
      end

            text3 = ''
            text3 << "__Moderation Commands:__\n\n"
            text3 << "The user executing these commands needs the appropriate permission. For example to use `#{Config.prefix}clear`, you need Manage Messages.\n"
            text3 << "`#{Config.prefix}kick @user <reason>`: Temporarily Kick somebody from the server.\n"
            text3 << "`#{Config.prefix}ban @user <reason>`: Permanently Ban somebody from the server. \n"
            text3 << "`#{Config.prefix}clear <num of messages>`: Deletes specified amount messages from the current channel.\n"
            text3 << "\n"
            if Helper.isadmin?(event.user)
                text3 << "__Admin Commands:__\n\n"
                text3 << "Only the Bot Owners may use these commands.\n"
                text3 << "`#{Config.prefix}message <ruby code>`: Sends the result of a Ruby eval as DM.\n"
                text3 << "`#{Config.prefix}game <text>`: Sets the \"Playing\" status of the bot.\n"
                text3 << "`#{Config.prefix}username <text>`: Sets the username of the bot.\n"
                text3 << "`#{Config.prefix}status <status>`: Changes the status of the bot to one of the options of idle, dnd, invisible or online."
                text3 << "`#{Config.prefix}owner <ID>`: Find the Server Owner. Uses current server if no ID is given.\n"
                text3 << "`#{Config.prefix}shutdown`: Turns the bot off.\n"
                text3 << "`#{Config.prefix}eval <code>`: Evaluate Ruby code.\n"
                text3 << "`#{Config.prefix}bash <code>`: Evaluate code on the commandline.\n"
                text3 << "`#{Config.prefix}spam <num> <text>`: Repeat a message a set number of times.\n"
                text3 << "`#{Config.prefix}upload <filepath>`: Upload a locally stored file to Discord.\n"
                text3 << "`#{Config.prefix}dump <channel_id>`: Dump and save all messages in a channel.\n"
                text3 << "`#{Config.prefix}command [add/remove] <text>`: Create a custom command.\n"
            end
            event.user.pm(text3)
            # We don't need to say this if it's currently in a DM.
            event.respond("✅ I've DMed you the command list!") unless event.channel.private?
        end
      end
end
