module JackusBot
	module Images
		extend Discordrb::Commands::CommandContainer
		
		command(:furry, help_available: false, max_args: 0) do |event|
			furries = Dir.entries("images/furries/")
			furry = furries.sample(1)
			#puts furries
			# puts furry
			furries.delete('.')
			furries.delete('..')
			furry_file = furry.join()
			puts furry_file
			event.channel.send_file File.new(['images/furries/' + furry_file].sample)
		end	 

		command(:eevee, help_available: false, max_args: 0) do |event|
			eevees = Dir.entries("images/eevee/")
			eevee = eevees.sample(1)
			# puts eevees
			# puts eevee
			eevees.delete('.')
			eevees.delete('..')
			eevee_file = eevee.join()
			event.channel.send_file File.new(['images/eevee/' + eevee_file].sample)
		end
	end
end 
