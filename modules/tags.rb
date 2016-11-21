module SerieBot
	module Tags
		extend Discordrb::Commands::CommandContainer
		extend Discordrb::EventContainer
      extend Discordrb::Commands::CommandContainer

      command(:command,description: "Add a custom command.") do |event, arg1, arg2, *text|
				if !Helper.isadmin?(event.user)
	        event << "❌ You don't have permission for that!"
	        break
	      end
	  if arg1 == "add"
        break if event.channel.private?
		response = text.join(" ")
        command(arg2.to_sym) do
			response
        end
		"Added command #{arg2} with response #{response}!"
		elsif arg1 == "remove"
		        event.bot.remove_command(arg2.to_sym)


        "Deleted command #{arg2}!"
		end

	end
	end
end
