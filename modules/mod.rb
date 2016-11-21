module SerieBot
	module Mod
		extend Discordrb::Commands::CommandContainer
		command(:clear , max_args: 1, required_permissions: [:manage_messages], description: 'Deletes x messages, mod only.', usage: '&clear x') do |event, count|
			if count.nil?
				event.respond("No argument specicied. Enter a valid number!")
				break
			end

			if !/\A\d+\z/.match(count)
				event.respond("`#{count}` is not a valid number!")
				break
			end
				original_num = count.to_i
				clearnum = count.to_i + 1

				while clearnum > 0
					if clearnum >= 99
						event.channel.prune(99)
						clearnum -= 99
					else
						event.channel.prune(clearnum)
						clearnum = 0
					end
				end
				message = event.respond("🚮  Cleared #{original_num} messages!")
				sleep(3)
				message.delete
			nil
		end

		command(:kick, description: "Temporarily Kick somebody from the server. Mod only.", required_permissions: [:kick_members],usage: '&kick @User reason', min_args: 2) do |event, *kickreason|
			member = event.server.member(event.message.mentions[0])

			break if event.channel.private?
			if event.message.mentions[0]
				finalmessage = kickreason.drop(1)
				display = finalmessage.join(" ")
        event.server.kick(member) rescue next
				member.pm("You have been kicked from the server **#{event.server.name}** by #{event.message.author.mention} | **#{event.message.author.display_name}**\nThey gave the following reason: ``#{display}``")

			else
				"Invalid argument. Please mention a valid user."
			end
		end


		command(:ban, description: "Permanently ban someone from the server. Mod only.",required_permissions: [:ban_members], usage: '&ban @User reason', min_args: 2) do |event, *banreason|
			member = event.server.member(event.message.mentions[0])
			break if event.channel.private?
			if event.message.mentions[0]
				finalbanmessage = banreason.drop(1)
				bandisplay = finalbanmessage.join(" ")
        event.server.ban(member) rescue next
					member.pm("You have been **permanently banned** from the server #{event.server.name} by #{event.message.author.mention} | **#{event.message.author.display_name}**
They gave the following reason: ``#{bandisplay}``
If you wish to appeal for your ban's removal, please contact this person, or the server owner.")

			else
				"Invalid argument. Please mention a valid user."
			end
		end

	end
end
