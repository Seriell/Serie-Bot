module SerieBot
    module Mod
        extend Discordrb::Commands::CommandContainer
        command(:clear, max_args: 1, required_permissions: [:manage_messages], description: 'Deletes x messages, mod only.', usage: '&clear x') do |event, count|
          Helper.ignore_bots(event)
            if count.nil?
                event.respond('No argument specicied. Enter a valid number!')
                break
            end

            unless /\A\d+\z/ =~ count
                event.respond("`#{count}` is not a valid number!")
                break
            end
            original_num = count.to_i
            clearnum = count.to_i + 1

            begin
                while clearnum > 0
                    if clearnum >= 99
                        # Welcome back to Workaround city.
                        ids = []
                        event.channel.history(99).each { |x| ids.push(x.id) }
                        Discordrb::API::Channel.bulk_delete_messages(event.bot.token, event.channel.id, ids)
                        clearnum -= 99
                    else
                        ids = []
                        event.channel.history(clearnum).each { |x| ids.push(x.id) }
                        Discordrb::API::Channel.bulk_delete_messages(event.bot.token, event.channel.id, ids)
                        clearnum = 0
                    end
                  end
                message = event.respond("🚮  Cleared #{original_num} messages!")
                sleep(3)
                message.delete
            rescue Discordrb::Errors::NoPermission
                event.respond("❌ I don't have permission to delete messages!")
                break
            end
            nil
        end

        command(:kick, description: 'Temporarily Kick somebody from the server. Mod only.', required_permissions: [:kick_members], usage: '&kick @User reason', min_args: 2) do |event, *kickreason|
          Helper.ignore_bots(event)
            member = event.server.member(event.message.mentions[0])

            break if event.channel.private?
            if event.message.mentions[0]
                finalmessage = kickreason.drop(1)
                display = finalmessage.join(' ')
                begin
                        event.server.kick(member)
                    rescue
                        next
                    end
                member.pm("You have been kicked from the server **#{event.server.name}** by #{event.message.author.mention} | **#{event.message.author.display_name}**\nThey gave the following reason: ``#{display}``")

            else
                'Invalid argument. Please mention a valid user.'
            end
        end

        command(:ban, description: 'Permanently ban someone from the server. Mod only.', required_permissions: [:ban_members], usage: '&ban @User reason', min_args: 2) do |event, *banreason|
          Helper.ignore_bots(event)
            member = event.server.member(event.message.mentions[0])
            break if event.channel.private?
            if event.message.mentions[0]
                finalbanmessage = banreason.drop(1)
                bandisplay = finalbanmessage.join(' ')
                begin
                        event.server.ban(member)
                    rescue
                        next
                    end
                member.pm("You have been **permanently banned** from the server #{event.server.name} by #{event.message.author.mention} | **#{event.message.author.display_name}**
        They gave the following reason: ``#{bandisplay}``
        If you wish to appeal for your ban's removal, please contact this person, or the server owner.")

            else
                'Invalid argument. Please mention a valid user.'
            end
        end

        command(:lockdown, required_permissions: [:administrator]) do |event, time, *reason|
          Helper.ignore_bots(event)
            reason = reason.join(' ')
            lockdown = Discordrb::Permissions.new
            lockdown.can_send_messages = true
            everyone_role = Helper.role_from_name(event.server, '@everyone')
            event.channel.define_overwrite(everyone_role, 0, lockdown)
            if time.nil?
                event.respond("🔒 **This channel is now in lockdown. Only staff can send messages. **🔒")
            elsif /\A\d+\z/ =~ time
                event.respond("🔒 **This channel is now in lockdown. Only staff can send messages. **🔒\n**Time:** #{time} minute(s)")
                time_sec = time * 60
                sleep(time_sec)
                lockdown = Discordrb::Permissions.new
                lockdown.can_send_messages = true
                everyone_role = Helper.role_from_name(event.server, '@everyone')
                event.channel.define_overwrite(everyone_role, lockdown, 0)
                event.respond(':unlock: **Channel has been unlocked.**:unlock:')
            end
        end

        command(:unlockdown, required_permissions: [:administrator]) do |event|
          Helper.ignore_bots(event)
            lockdown = Discordrb::Permissions.new
            lockdown.can_send_messages = true
            everyone_role = Helper.role_from_name(event.server, '@everyone')
            event.channel.define_overwrite(everyone_role, lockdown, 0)
            event.respond(':unlock: **Channel has been unlocked.**:unlock:')
        end
    end
end
