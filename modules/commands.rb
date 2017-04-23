module SerieBot
    module Commands
        extend Discordrb::Commands::CommandContainer
        class << self
          attr_accessor :image_commands
          attr_accessor :text_commands
        end
        command(:error, max_args: 1, min_args: 1) do |event, code|
            event.respond("https://wiimmfi.de/error?e=#{code}")
        end

        command(:owners) do |event|
            event << 'This bot instance is managed/owned by the following users. Please contact them for any issues.'
            Config.bot_owners.each { |x| event << "`#{event.bot.user(x).distinct}`" }
            nil
        end

        @text_commands = {
            # :name => 'Text response!'
            kappa: '
      ░░░░▄▀▀▀▀▀█▀▄▄▄▄░░░░
      ░░▄▀▒▓▒▓▓▒▓▒▒▓▒▓▀▄░░
      ▄▀▒▒▓▒▓▒▒▓▒▓▒▓▓▒▒▓█░
      █▓▒▓▒▓▒▓▓▓░░░░░░▓▓█░
      █▓▓▓▓▓▒▓▒░░░░░░░░▓█░
      ▓▓▓▓▓▒░░░░░░░░░░░░█░
      ▓▓▓▓░░░░▄▄▄▄░░░▄█▄▀░
      ░▀▄▓░░▒▀▓▓▒▒░░█▓▒▒░░
      ▀▄░░░░░░░░░░░░▀▄▒▒█░
      ░▀░▀░░░░░▒▒▀▄▄▒▀▒▒█░
      ░░▀░░░░░░▒▄▄▒▄▄▄▒▒█░
      ░░░▀▄▄▒▒░░░░▀▀▒▒▄▀░░
      ░░░░░▀█▄▒▒░░░░▒▄▀░░░
      ░░░░░░░░▀▀█▄▄▄▄▀░░░░
      ░░░░░░░░░░░░░░░░░░░░',

            moo: '```                 (__)
                     (oo)
               /------\/
              / |    ||
             *  /\---/\
                ~~   ~~
    ..."Have you mooed today?"...```',
            lenny: '( ͡° ͜ʖ ͡°)',
            shrug: '¯\_(ツ)_/¯',
            support: "⚙ **Need help?**\nYou can join the support server here:\n**https://discord.gg/43SaDy6 **",
            facedesk: 'https://giphy.com/gifs/XLOsdacfjL5cI',
            smea: 'https://giphy.com/gifs/Sb2NkTl1oV6eI',
            milk: 'I am a frequent ice chewer and I recently discovered "milk" :wink: ice. Firstly you put "milk" :wink: in the ice tray and then you let it freeze. I got so addicted to this that I covered my whole freezer with "milk" :wink: ! Of course nothing beats the original water so sometimes I shave a half cup of water with half cup of "milk" :wink: and crunch away. It' + "'" + 's probably bad for me but I also try "lemon" :wink: mixed with "milk" :wink: :wink:',
            mine: "This mailbox :mailbox: is mine :thumbsup: and this triangular sign :zzz: that blue balloon :balloon: the month of June :calendar: there mine mine mine mine Mine ziggy's sweets :candy: are mine :thumbsup: the birdies tweets are mine! :thumbsup: city streets :walking: both ur feet :feet: there all emphatically mine :thumbsup: it's all belong to me :open_hands: everything that I see :see_no_evil: north south east and west I caress it :open_hands: cause I possess it, I'm stingy and it's mine!!!!! :thumbsup::thumbsup::thumbsup: snap snap snap :ok_hand::ok_hand: And this instrumental break is also mine :thumbsup::thumbsup: the floor :thumbsdown: and ceiling :thumbsup: are mine all your feeling are mine :slight_smile::confused::cry::angry::thinking:  you always knew it! That's all there is to it! It's mine mine mine mine mine :raised_hands: that's what I said it's mine!",            
        }

        @text_commands.each do |name, text|
            command(name, description: name) do |event|
                begin
                      next if Config.blacklisted_channels.include?(event.channel.id)
                  rescue
                      nil
                  end
                event.channel.start_typing
                event.respond(text)
            end
            puts "Command #{Config.prefix}#{name} loaded successfully!"
        end

        command(:about, min_args: 0, max_args: 0) do |event|
            about_text = "`#{event.bot.user(event.bot.profile.id).distinct}` running **SerieBot-Git v3-#{`git rev-parse --short HEAD`}** \n**<https://github.com/Seriell/Serie-Bot> \n**"
            if Config.yuu_commands
                about_text += '⚙ Extra commands: **Enabled**'
            else
                about_text += '⚙ Extra commands: **Disabled**'
            end
            about_text += "\n\n:moneybag: Hey, making bots and hosting them isn't free. If you want this bot to stay alive, consider giving some :dollar: to the devs: https://paypal.me/Seriel and https://paypal.me/spotlightisok"
            event.respond(about_text)
        end

        command(:owner, description: 'Find the owner of a shared server.', usage: '&message code') do |event, id|
            if event.channel.private?
                event.respond("❌ Sorry, you can't find the owner of a DM! (Hint: it's you.)")
                break
            end
            id = event.server.id if id.nil?
            owner = event.bot.server(id).owner
            event.respond("👤 Owner of server `#{event.bot.server(id).name}` is **#{owner.distinct}** | ID: `#{owner.id}`")
        end

        command(:help, description: 'Display a list of commands.') do |event|
          event.channel.start_typing
          help_text = "We no longer DM you commands, so here's a wiki page.\n"
          help_text << '**🔗 https://github.com/Seriell/Serie-Bot/wiki/Commands**'
        end
        command(:invite) do |_event|
          "👋 Invite me to your server here: \n**#{Config.invite_url}**"
        end
    end
end
