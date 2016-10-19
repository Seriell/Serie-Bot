module SerieBot
	module Food
	extend Discordrb::Commands::CommandContainer
		
		commands = ["potato", "cake", "cookie", "sandwich", "taco", "coffee", "noodles", "muffin", "tea", "keto", "beer", "cheese", "pancake", "chicken", "nugget", "pie", "brekkie", "icecream", "pizza", "chocolate", "pasta", "cereal"]
		commands.each { |x| 
		
		command(x.to_sym, description: 'give #{x} to <user>') do |event, user|
		if !event.message.mentions[0]
			event.respond("I can't give #{x} to that user.")
			break
		end
		user = "**#{event.message.mentions[0].name}**"
		event.respond( `python "modules/data/foods.py" "#{user}" #{x}`)
		end
		

		puts "Loaded food command for `#{x}`"
		}

	end
end
	