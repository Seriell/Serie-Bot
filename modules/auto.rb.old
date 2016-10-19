module JackusBot
	module Auto
	
		extend Discordrb::EventContainer
		member_join() do |event|
			# JackusBot.init_roles
			break unless event.server.id == JackusConfig.server_id
			event.bot.send_message(JackusConfig.logs_channel, "#{event.user.mention} has just joined the server! :D") #Display a message when a user joins.
			roles = event.server.roles #Store the roles in an array for easy access.
			event.member.add_role(JackusBot.role(event.server)) #Give new role
		end
		
		member_leave() do |event|
			break unless event.server.id == JackusConfig.server_id
			event.bot.send_message(JackusConfig.logs_channel, "#{event.user.mention} | **#{event.user.name}** has just left the server! :(") #Display a message when a user joins.
		end
	end
end