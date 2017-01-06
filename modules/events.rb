module SerieBot
    module Events
        extend Discordrb::Commands::CommandContainer
        extend Discordrb::EventContainer



# REMOVED

=begin
        if Config.use_cleverbot
          require 'cleverbot'
          extend Discordrb::Commands::CommandContainer
          extend Discordrb::EventContainer
          friend = Cleverbot.new(Config.cleverbot_api_user, Config.cleverbot_api_token)

          message do |event|
              if event.message.content.start_with?(event.bot.user(event.bot.profile.id).mention)
                  message = event.message.content.slice!(event.bot.user(Config.appid).mention.length, event.message.content.size)
                  response = friend.say(message)
                  event.respond("💬 #{response}") unless response.nil?
              end
        end
=end

            ready do |event|
                event.bot.online
                event.bot.game = Config.playing
                puts 'Bot succesfully launched!'
                if Config.bot_owners.nil? or Config.bot_owners == []
                  puts "/!\\The bot owner has not been set! Please set this to your user ID as soon as possible.\nYou can get your ID by either:\n-Enabling Discord Developer mode and right clicking your name, then Copy ID.\n-Typing #{Config.prefix}info into any chat where the bot has permissions."
                end
            end
    end
end
