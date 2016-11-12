module SerieBot
	module Commands
		extend Discordrb::Commands::CommandContainer

		command(:tell, description: "Send a message!.",usage: "#{Config.prefix}tell @User#1234 <message>") do |event, mention, *pmwords|
			if !mention.start_with?('<@', '<@!')
				event << ":x: Mention a valid user!"
				break
			end
			message = pmwords.join(" ")
			member = event.message.mentions[0]
			member.pm("`#{event.author.distinct}` says: \n #{message}")
			event.respond(":white_check_mark: Your message has been sent!")
		end

		command(:avatar, description: "Displays the avatar of a user.") do |event, *mention|
      event.channel.start_typing
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
      event.channel.start_typing
			break if event.channel.private? # ignore PMs
			if event.message.mentions[0]
				user = event.message.mentions[0]
				if user.game.nil?
					playing = "[N/A]"
				else
					playing = user.game
				end


				member = user.on(event.server)

        if member.nickname.nil?
					nick = "[N/A]"
				else
					nick = member.nickname
				end
				message= "👥  Infomation about **#{member.display_name}**
-ID: **#{user.id}**
-Username: `#{user.distinct}`
-Nickname: **#{nick}**
-Status: **#{user.status}**
-Playing: **#{playing}**
-Account created: **#{user.creation_time}**
-Joined server at: **#{member.joined_at}**
-Avatar:"
				event.respond(message)
        event.channel.start_typing
				url = user.avatar_url
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
        event.channel.start_typing
				qrtext = text.join(" ")
				url = "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=#{qrtext}"
        filepath = "tmp/qr.png"
        FileUtils.rm(filepath) if File.exist?(filepath)
				File.new filepath,"w"
        File.open(filepath, "wb") do |file|
					file.write open(url).read
				end
				event.channel.send_file File.new(filepath)
		end

		command(:say, help_available: false) do |event, *words|
      event.channel.start_typing
			if event.user.bot_account?
				event.bot.ignore_user(event.user)
				next
			end

			break if words.length == 0
			message = words.join(" ")
			break if message.nil?
			event.respond message
		end

		command(:speak, description: "Say something and then remove all traces of you telling the bot to say it :^)") do |event, *words|
			if event.user.bot_account?
				event.bot.ignore_user(event.user)
				next
			end
			message = words.join(" ")
			event.respond message
			event.message.delete
		end
	end
end
