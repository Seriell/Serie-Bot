module JackusBot
	module Admin
	extend Discordrb::Commands::CommandContainer
		def self.isadmin?(member)
      member.id == 228574821590499329  or member.id == 172806613948825600 or member.id == 162411191497392128 #Seriel or luigoalma or Supster131
    end

		command(:message, description: "Send the result of an eval in PM. Admin only.",usage: '&message code') do |event, *pmwords|

			break if !isadmin?(event.user)

			puts pmwords
			message = pmwords.join(" ")
			puts message
			event.user.pm(eval message)
		end

		command(:send, description: "Send a message to yourself!",usage: '&send <message>') do |event, *pmwords|
			message = pmwords.join(" ")
			event.user.pm(message)
		end

		command(:shutdown, description: "Shuts down the bot. Admin only.",usage: '&shutdown') do |event|
			puts "#{event.author.distinct}: \`#{event.message.content}\`"
			if !isadmin?(event.user)
				event.respond("You don't have permission for that!")
				break
			end

				event.respond "Goodbye!"
				exit
		end
		command(:eval, description: "Evaluate a Ruby command. Admin only.",usage: '&eval code') do |event, *code|
			puts "#{event.author.distinct}: \`#{event.message.content}\`"
			if !isadmin?(event.user)
				event.respond("You don't have permission for that!")
				break
			end
			eval code.join(' ')
		end
		command(:bash, description: "Evaluate a Bash command. Admin only. Use with care.",usage: '&bash code') do |event, *code|
			puts "#{event.author.distinct}: \`#{event.message.content}\`"
			if !isadmin?(event.user)
				event.respond("You don't have permission for that!")
				break
			end
			bashcode = code.join(' ')
			eval "`#{bashcode}`"
		end
		command(:upload, description: "Upload a file to Discord. Admin only.",usage: '&upload filename') do |event, *file|
			if !isadmin?(event.user)
				event.respond("You don't have permission for that!")
				break
			end
			filename = file.join("" )
			eval event.channel.send_file File.new([filename].sample)
			end

		command(:dump, description: "Dumps a selected channel. Admin only.",usage: '&dump [id]') do |event, input_id|
			if !isadmin?(event.user)
				event.respond("You don't have permission for that!")
				break
			end
			#Only I can use this command okay.
			channel_id = input_id

			if channel_id.nil?
				channel_id = event.channel.id
			end
			channel = event.bot.channel(channel_id)

			#Only I can use this command okay.
			if channel.private?
				server = "DMs"
			else
				server = channel.server.name
			end

			event.respond("Dumping messages from channel \"#{channel.name.gsub("`", "\\`")}\" in #{server.gsub("`", "\\`")}, please wait...")
			if !(channel.private?)
				output_filename = "output_" + server + "_" + channel.server.id.to_s + "_" + channel.name + "_" + channel.id.to_s + "_" + event.message.timestamp.to_s + ".txt"
			else
				output_filename = "output_" + server + "_" + channel.name + "_" + channel.id.to_s + "_" + event.message.timestamp.to_s + ".txt"
			end
			output_filename = output_filename.gsub(" ","_").gsub("+","").gsub("\\","").gsub("/","").gsub(":","").gsub("*","").gsub("?","").gsub("\"","").gsub("<","").gsub(">","").gsub("|","")
			hist_count_and_messages = [Array.new, [0, Array.new]]

			output_file = File.open(output_filename, 'w')
			offset_id = channel.history(1,1,1)[0].id #get first message id

			#Now let's dump!
			while true
				hist_count_and_messages[0] = channel.history(100, nil, offset_id) # next 100
				break if hist_count_and_messages[0] == []
				hist_count_and_messages[1] = JackusBot.parse_history(hist_count_and_messages[0], hist_count_and_messages[1][0])
				output_file.write((hist_count_and_messages[1][1].reverse.join("\n") + "\n").encode("UTF-8")) #write to file right away, don't store everything in memory
				output_file.flush #make sure it gets written to the file
				offset_id = hist_count_and_messages[0][0].id
			end
			output_file.close
			puts "Uploading output..."
			event.respond("#{hist_count_and_messages[1][0]} messages logged.")
			event.channel.send_file File.new([output_filename].sample)
			puts "Done. Dump file: #{output_filename}"
		end
  end
end
