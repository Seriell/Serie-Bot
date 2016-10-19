module SerieBot
	module Tags
		extend Discordrb::Commands::CommandContainer
		extend Discordrb::EventContainer
      extend Discordrb::Commands::CommandContainer
      command(:command,description: "Add a custom command with the bot. Staff only.\n") do |event, arg1, arg2, *text|
	  if arg1 == "add"
        break if event.channel.private?
		response = text.join(" ")
        event.bot.command(arg2.to_sym) do
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
	