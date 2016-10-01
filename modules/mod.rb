module JackusBot
	module Mod
		extend Discordrb::Commands::CommandContainer
		command(:clear , max_args: 1, required_permissions: [:manage_messages], description: 'Deletes x messages, mod only.', usage: '&clear x') do |event, count|
			#if !event.author.permission?(8192, event.channel)
			#	event.respond("You don't have permission for that!") unless event.author.id == 110833169757945856
			#	break unless event.author.id == 110833169757945856
			#end
			if count.nil?
					event.respond("No argument specicied. Enter a valid number!")
					break
			end
			 if !/\A\d+\z/.match(count)
					event.respond("`#{count}` is not a valid number!")
					break
				end
				clearnum = count.to_i
			if clearnum > 100
				event.respond("Cannot clear more than 100 messages at a time!")
				break
			else
				event.channel.prune(clearnum + 1)
				message = event.respond(":put_litter_in_its_place:  Cleared #{clearnum} messages!")
				sleep(3)
				message.delete
			end
			nil
		end

		command(:verify , max_args: 1, min_args: 1, required_permissions: [:manage_messages], description: 'Verify a new user to grant full access to the server. Mod only.', usage: '&verify @User') do |event, member|

			if event.message.mentions[0]
				member = event.server.member(event.message.mentions[0])
				#if !event.author.permission?(3, event.channel)
				#	event.respond("You don't have permission for that!") unless event.author.id == 110833169757945856
				#	break unless event.author.id == 110833169757945856
				#end

				if !member.roles.include? JackusBot.new_role(event.server)
				puts member.name
					event.respond("That member is already verified!")
					break
				end

				member.remove_role(JackusBot.new_role(event.server))
				member.add_role(JackusBot.cool_role(event.server))
				event.respond("**#{member.name}** successfully verified by #{event.message.author.mention}!")
				event.bot.send_message(JackusConfig::logs_channel, "**#{member.name}** successfully verified by **#{event.message.author.nick}**!") if event.server.id == JackusConfig::server_id
			else
				"Invalid argument. Please mention a valid user."
			end
		end

		command(:kick, description: "Temporarily Kick somebody from the server. Mod only.", required_permissions: [:kick_members],usage: '&kick @User reason', min_args: 2) do |event, *kickreason|
			member = event.server.member(event.message.mentions[0])
		#	if !event.author.permission?(2, event.channel)
		#		event.respond("You don't have permission for that!") unless event.author.id == 110833169757945856
		#		break unlless event.author.id == 110833169757945856
	#		end
			if JackusBot.check_mod(member, event.server)
				event.respond("You can't kick a fellow staff member!")
				break
			end

			break if event.channel.private?
			if event.message.mentions[0]
				finalmessage = kickreason.drop(1)
				display = finalmessage.join(" ")

				member.pm("You have been kicked from the server **#{event.server.name}** by #{event.message.author.mention} | **#{event.message.author.display_name}**
They gave the following reason: ``#{display}``")
				event.bot.send_message(JackusConfig::logs_channel, "#{member.mention} | **#{member.name}**
Has been kicked by: #{event.message.author.mention} | **#{event.message.author.name}**
For reason: ``#{display}``") if event.server.id == JackusConfig.server_id
				event.server.kick(member)
			else
				"Invalid argument. Please mention a valid user."
			end
		end


		command(:ban, description: "Permanently ban someone from the server. Mod only.",required_permissions: [:ban_members], usage: '&ban @User reason', min_args: 2) do |event, *banreason|
			#if !event.author.permission?(4, event.channel)
			#	event.respond("You don't have permission for that!") unless event.author.id == 110833169757945856
			#	break unless event.author.id == 110833169757945856
			##end
			member = event.server.member(event.message.mentions[0])
			if JackusBot.check_mod(member, event.server)
				event.respond("You can't kick a fellow staff member!")
				break
			end
			break if event.channel.private?
			if event.message.mentions[0]
				finalbanmessage = banreason.drop(1)
				bandisplay = finalbanmessage.join(" ")
					member.pm("You have been **permanently banned** from the server #{event.server.name} by #{event.message.author.mention} | **#{event.message.author.display_name}**
They gave the following reason: ``#{bandisplay}``
If you wish to appeal for your ban's removal, please contact this person, or the server owner.")

				event.bot.send_message(JackusConfig::logs_channel, "#{member.mention} | **#{member.name}**
Has been banned by: #{event.message.author.mention} | **#{event.message.author.name}**
For reason: ``#{bandisplay}``") if event.server.id == JackusConfig.server_id
				event.server.ban(member)
			else
				"Invalid argument. Please mention a valid user."
			end
		end

	end
end
