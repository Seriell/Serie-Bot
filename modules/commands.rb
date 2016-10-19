module SerieBot
	module Commands
		extend Discordrb::Commands::CommandContainer

		command(:lenny, description: 'Memes') do |event|
			event.respond('( ͡° ͜ʖ ͡°)')
		end
		command(:tell, description: "Send a message!.",usage: '&tell @User message') do |event, mention, *pmwords|
			break if !mention.start_with?('<@', '<@!')
			message = pmwords.join(" ")
			member = event.message.mentions[0]
			member.pm("`#{event.author.distinct}` says: \n #{message}")
			event.respond(":white_check_mark: Your message has been sent!")
		end
		command(:shrug, description: 'Memes') do |event|
			event.respond('¯\_(ツ)_/¯')
		end
		command(:about, description: 'Things') do |event|

			event.respond("#{event.bot.profile.username} running `Serie-Bot v3 testing build`")
		end

		command(:error,max_args: 5, min_args: 1, description: 'Find error details I guess.') do |event, *code|
			url = "https://wiimmfi.de/error?e=#{code.join(",")}"
			puts url
			event.respond(url)
		end

		command(:ping, description: 'ping') do |event|
			event.respond('pong')
		end

		command(:fc, description: 'FREINDSSS') do |event|
		break if !event.server.id == 206934458954153984
			event.respond('Please add your friend codes here:
https://docs.google.com/spreadsheets/d/1DzXx17ZceMKYmRgoqZd3ROBm03GzDMihVnKOfIcXFwQ/edit?usp=sharing')
		end

		command(:avatar, description: "Displays the avatar of a user.") do |event, *mention|
			break if event.channel.private? # ignore PMs
			if event.message.mentions[0] or !mention.nil?
				if mention.nil?
					member = event.message.author
				else
					member = event.server.member(event.message.mentions[0])
				end
				url = member.avatar_url
				uri = URI.parse(url)
				filename = File.basename(uri.path)
				FileUtils.rm("avatars/#{filename}") if File.exist?("avatars/#{filename}")

				File.new "avatars/#{filename}","w"
				File.open("avatars/#{filename}", "wb") do |file|
				  file.write open(url).read
				end
				event.channel.send_file File.new(['avatars/' + filename].sample)
			end
		end

		command(:info, description: "Displays info about a user.") do |event, *mention|
			break if event.channel.private? # ignore PMs
			if event.message.mentions[0]
				member = event.message.mentions[0]
				if member.game.nil?
					playing = "[N/A]"
				else
					playing = member.game
				end
					
				message= "👥  Infomation about `#{member.distinct}`
-ID: **#{member.id}**
-Name: **#{member.name}**
-Status: **#{member.status}**
-Playing: **#{playing}**
-Account created: **#{member.creation_time}**
-Avatar:"
				event.respond(message)
				url = member.avatar_url
				uri = URI.parse(url)
				filename = File.basename(uri.path)
				FileUtils.rm("avatars/#{filename}") if File.exist?("avatars/#{filename}")

				File.new "avatars/#{filename}","w"
				File.open("avatars/#{filename}", "wb") do |file|
					file.write open(url).read
				end
				event.channel.send_file File.new(['avatars/' + filename].sample)
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
			if event.user.bot_account?
				event.bot.ignore_user(event.user)
				next
			end
				
			break if words.length == 0
			message = words.join(" ")
			break if message == nil or message == " "
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
			if event.user.bot_account?
				event.bot.ignore_user(event.user)
				next
			end
			puts "---#{event.message.author.distinct}: #{event.message.content}"
			message = words.join(" ")
			break if message.start_with?('t@')
			break if message.start_with?('t!')
			event.respond message
			event.message.delete
		end
	end
end
