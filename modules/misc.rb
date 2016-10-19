module SerieBot
	module Misc
	extend Discordrb::Commands::CommandContainer
		
		commands = ["larts", "insult", "kill", "slap", "compliment", "strax", "flirt", "present"]
		commands.each { |x| 
		
		command(x.to_sym) do |event, user|
		if !event.message.mentions[0]
			break
		end
		user = "**#{event.message.mentions[0].name}**"
		event.respond( `python "modules/data/Attacks/attacks.py" "#{user}" #{x}`)
		end
		
		
		puts "Loaded food command for `#{x}`"
		}
		
		command(:nk) do |event, user|
			event.respond( `python "modules/data/Attacks/attacks.py" nk`)
		end
	end
end
	