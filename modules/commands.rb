module JackusBot
	module Commands
		extend Discordrb::Commands::CommandContainer
		
		command(:lenny, description: 'Memes') do |event|
			event.respond('( ͡° ͜ʖ ͡°)')
		end
		command(:help, description: 'helpppp') do |event| 
			break
		end
		command(:shrug, description: 'Memes') do |event|
			event.respond('¯\_(ツ)_/¯')
		end
		command(:lenny, description: 'Memes') do |event|
			event.respond('( ͡° ͜ʖ ͡°)')
		end
		command(:ping, description: 'ping') do |event|
			event.respond('pong')
		end
		
		command(:fc, description: 'FREINDSSS') do |event|
		break if !event.server.id == 206934458954153984
			event.respond('Please add your friend codes here:
https://docs.google.com/spreadsheets/d/1DzXx17ZceMKYmRgoqZd3ROBm03GzDMihVnKOfIcXFwQ/edit?usp=sharing')
		end
		
		command(:avatar, description: "Displays the avatar of a user.", min_args: 1) do |event|
			break if event.channel.private? # ignore PMs, this is going to rely on mentions
			if event.message.mentions[0]
				member = event.server.member(event.message.mentions[0])
				url = member.avatar_url
				uri = URI.parse(url)
				filename = File.basename(uri.path)
				eval `rm /avatars/{#filename}`
				eval `cd avatars && wget "#{member.avatar_url}" -O #{filename}`
				eval `cd avatars && wget #{member.avatar_url} `
				event.channel.send_file File.new(['avatars/' + filename].sample)
				# "#{member.mention}\'s avatar: #{member.avatar_url}"
			else
				"Invalid argument. Please mention a valid user."
			end
		end

		command(:qr, description: "Returns a QR code of an input.", min_args: 1) do |event, *text|
				qrtext = text.join(" ")
				url = "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=#{qrtext}"
				eval `rm /tmp/qr.png`
				eval `cd tmp && wget "#{url}" -O qr.png`
				#eval `cd avatars && wget #{member.avatar_url} `
				event.channel.send_file File.new(['tmp/qr.png'].sample)
		end

		command(:say, help_available: false) do |event, *words|
			puts "---#{event.message.author.distinct}: #{event.message.content}"

			message = words.join(" ")
			break if message.start_with?('t@')
			break if message.start_with?('t!')
			event.respond message
		end

		

		command(:hide, description: "Deletes the message as soon as it's sent. You are such a horrible person :^)") do |event, *words|
						puts "---#{event.message.author.distinct}: #{event.message.content}"

			message = words.join(" ")
			break if message.start_with?('t@')
			break if message.start_with?('t!')
			event.message.delete
		end

		command(:speak, description: "Say something and then remove all traces of you telling the bot to say it :^)") do |event, *words|
			puts "---#{event.message.author.distinct}: #{event.message.content}"
			message = words.join(" ")
			break if message.start_with?('t@')
			break if message.start_with?('t!')
			event.respond message
			event.message.delete
		end
	end
end
