module SerieBot
    module Events
        extend Discordrb::Commands::CommandContainer
        extend Discordrb::EventContainer
            ready do |event|

                event.bot.online
                event.bot.game = Config.playing
                Helper.load_settings
                event.bot.servers.each {|x,y|
                  if Data.settings[:blacklisted_servers].include?(y.id.to_s)
                    y.leave
                    puts "Left #{y.name} due to blacklist!!"
                  end
                }
                puts 'Bot succesfully launched!'
                if Config.bot_owners.nil? or Config.bot_owners == []
                  puts "/!\\The bot owner has not been set! Please set this to your user ID as soon as possible.\nYou can get your ID by either:\n-Enabling Discord Developer mode and right clicking your name, then Copy ID.\n-Typing #{Config.prefix}info into any chat where the bot has permissions."
                end
            end
    end
end
