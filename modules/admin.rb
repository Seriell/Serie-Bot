module SerieBot
    module Admin
        extend Discordrb::Commands::CommandContainer

        command(:save) do |event|
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
            end
            message = event.respond 'Saving...'
            Helper.save_settings
            message.edit('All saved!')
        end

        command(:message, description: 'Send the result of an eval in PM. Admin only.', usage: "#{Config.prefix}message code") do |event, *pmwords|
          Helper.ignore_bots(event)
            break unless Helper.isadmin?(event.user)

            eval code.join(' ')
        end

        command(:setavatar) do |event, *url|
          Helper.ignore_bots(event)
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
            end
            url = url.join(' ')
            file = Helper.download_file(url, 'tmp')
            event.bot.profile.avatar = File.open(file)
            event.respond('✅ Avatar should be updated!')
        end

        command(:game, description: 'Set the "Playing" status. Admin only.') do |event, *game|
          Helper.ignore_bots(event)
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
              end
            event.bot.game = game.join(' ')
            event.respond("✅ Game set to `#{game.join(' ')}`!")
        end

        command(:username, description: "Set the Bot's username. Admin only.", min_args: 1) do |event, *name|
          Helper.ignore_bots(event)
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
              end
            username = name.join(' ')
            event.bot.profile.name = begin
                                         username
                                     rescue
                                         event.respond('An error has occured!')
                                     end
            event.respond("Username set to `#{username}`!")
        end

        command(:ignore, description: 'Temporarily ignore a given user', min_args: 1, max_args: 1) do |event, mention|
          Helper.ignore_bots(event)
            event.channel.start_typing
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
            end
            user = begin
                     event.bot.parse_mention(mention)
                 rescue
                     event.respond("❌ `#{mention}` is not a valid user!")
                 end
            begin
              event.bot.ignore_user(user)
          rescue
              event.respond("❌ `#{mention}` is not a valid user!")
          end
            event.respond("✅ #{user.mention} has been temporarily ignored!")
        end

        command(:unignore, description: 'Unignores a given user', min_args: 1, max_args: 1) do |event, mention|
          Helper.ignore_bots(event)
            event.channel.start_typing
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
            end
            user = begin
                     event.bot.parse_mention(mention)
                 rescue
                     event.respond("❌ `#{mention}` is not a valid user!")
                 end
            begin
              event.bot.unignore_user(user)
          rescue
              event.respond("❌ `#{mention}` is not a valid user!")
          end
            event.respond("✅ #{user.mention} has been removed from the ignore list!")
        end

        command(:status, description: 'Set the bot as idle or dnd or invisible status. Admin only.', min_args: 1, max_args: 1) do |event, status|
          Helper.ignore_bots(event)
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
            end
            if status == 'idle'
                event.bot.idle
                event.respond("✅ Status set to **Idle**!")
            elsif status == 'dnd'
                event.bot.dnd
                event.respond("✅ Status set to **Do No Disturb**!")
            elsif status == 'online'
                event.bot.online
                event.respond("✅ Status set to **Online**!")
            elsif status == 'invisible' || status == 'offline'
                event.bot.invisible
                event.respond("✅ Status set to **Invisible**!")
            else
                event.respond('Enter a valid argument!')
            end
        end



        command(:blockserver) do |event,id|
          unless Helper.isadmin?(event.user)
              event.respond("❌ You don't have permission for that!")
              break
          end

          if Data.settings[:blacklisted_servers].include?(id)
            index = Data.settings[:blacklisted_servers].index(id)
            Data.settings[:blacklisted_servers][index] = nil

            event.respond("✅ Server removed from blacklist!")
          else
            Data.settings[:blacklisted_servers].push(id)
            begin
              server = event.bot.server(id)
              server.leave
              event.respond("✅ Server added to blacklist!")
            rescue
            end
          end
        end


        command(:shutdown, description: 'Shuts down the bot. Admin only.', usage: '&shutdown') do |event|
          Helper.ignore_bots(event)
            puts "#{event.author.distinct}: \`#{event.message.content}\`"
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
            end
            message = event.respond 'Saving and exiting... '
            Helper.save_settings
            event.bot.invisible
            message.edit('All saved. Goodbye!')
            Helper.quit
        end

        command(:eval, description: 'Evaluate a Ruby command. Admin only.', usage: "#{Config.prefix}eval code") do |event, *code|
          Helper.ignore_bots(event)
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
            end

           eval code.join(' ')
        end

        command(:spam, required_permissions: [:administrator], description: 'Spam a message. Admin only.', usage: '&spam num text') do |event, num, *text|
          Helper.ignore_bots(event)
            puts "#{event.author.distinct}: \`#{event.message.content}\`"
            if num.nil?
                event.respond('No argument specicied. Enter a valid positive number!')
                break
            end

            if !/\A\d+\z/.match(num)
                event.respond("❌ `#{num}` is not a valid positive number!")
                break
            else num == 0
                 event.respond("❌ You can't spam zero times!")
            end

            num = num.to_i

            while num > 0
                event.respond(text.join(' ').to_s)
                num -= 1
            end
        end

        command(:bash, description: 'Evaluate a Bash command. Admin only. Use with care.', usage: '&bash code') do |event, *code|
          Helper.ignore_bots(event)
            event.channel.start_typing
            unless Helper.isadmin?(event.user)
                event.respond("❌ You don't have permission for that!")
                break
            end
            bashcode = code.join(' ')
            # Capture all output, including STDERR.
            toBeRun = "#{bashcode} 2>&1"
            result = ` #{toBeRun} `
            event << if result.nil? || result == '' || result == ' ' || result == "\n"
                         "✅ Done! (No output)"
                     else
                         "Output: ```\n#{result}```"
                     end
        end

        command(:upload, description: 'Upload a file to Discord. Admin only.', usage: '&upload filename') do |event, *file|
          Helper.ignore_bots(event)
            event.channel.start_typing
            unless Helper.isadmin?(event.user)
                event << "❌ You don't have permission for that!"
                break
            end
            filename = file.join('')
            event.channel.send_file File.new([filename].sample)
        end

        command(:rehost) do |event, *url|
          Helper.ignore_bots(event)
            event.channel.start_typing
            url = url.join(' ')
            file = Helper.download_file(url, 'tmp')
            Helper.upload_file(event.channel, file)
            event.message.delete
        end

        command(:dump, description: 'Dumps a selected channel. Admin only.', usage: '&dump [id]') do |event, channel_id|
          Helper.ignore_bots(event)
            unless Helper.isadmin?(event.user)
                event << "❌ You don't have permission for that!"
                break
            end
            channel_id = event.channel.id if channel_id.nil?
            channel = begin
                        event.bot.channel(channel_id)
                    rescue
                        event.respond("❌ Enter a valid channel id!")
                    end

            Helper.dump_channel(channel, event.channel, Config.dump_dir, event.message.timestamp)
            event.respond('✅ Dumped successfully!')
        end

        command(:prune, required_permissions: [:manage_messages], max_args: 1) do |event, num|
          Helper.ignore_bots(event)
            begin
                num = 50 if num.nil?
                count = 0
                event.channel.history(num).each do |x|
                    if x.author.id == event.bot.profile.id
                        x.delete
                        count += 1
                    end
                end
                message = event.respond("✅ Pruned #{count} messages!")
                sleep(10)
                message.delete
                event.message.delete
            rescue Discordrb::Errors::NoPermission
                event.channel.send_message("❌ I don't have permission to delete messages!")
                puts 'The bot does not have the delete message permission!'
            end
        end

        command(:pruneuser, required_permissions: [:manage_messages], max_args: 1) do |event, user, num|
          Helper.ignore_bots(event)
            begin
                 user = event.bot.parse_mention(user)
                 num = 50 if num.nil?
                 count = 0
                 event.channel.history(num).each do |x|
                     if x.author.id == user.id
                         x.delete
                         count += 1
                     end
                 end
                 message = event.respond("✅ Pruned #{count} messages!")
                 sleep(10)
                 message.delete
                 event.message.delete
             rescue Discordrb::Errors::NoPermission
                 event.channel.send_message("❌ I don't have permission to delete messages!")
                 puts 'The bot does not have the delete message permission!'
             end
        end
    end
end
