module SerieBot
	module Utility
		extend Discordrb::Commands::CommandContainer

		command(:tell, description: "Send a message!.",usage: "#{Config.prefix}tell @User#1234 <message>") do |event, mention, *pmwords|
			if !mention.start_with?('<@', '<@!')
				event << "❌ Mention a valid user!"
				break
			end
			message = pmwords.join(" ")
			member = event.message.mentions[0]
			member.pm("`#{event.author.distinct}` says: \n #{message}")
			event.respond("✅ Your message has been sent!")
		end

		command(:space) do |event, *args|
			event.channel.start_typing
			text = args.join(' ').gsub(/(.{1})/, '\1 ')
			event << text
		end

		command(:angry) do |event, *args|
			event.channel.start_typing
			text = args.join(' ').gsub(/(.{1})/, '\1 ').upcase
			event << "** *#{text}* **"
		end

		command(:avatar, description: "Displays the avatar of a user.") do |event, *mention|
      event.channel.start_typing # Let people know the bot is working on something.
				if mention.nil?
					user = event.message.author
				elsif event.message.mentions[0]
					user = event.server.member(event.message.mentions[0])
				else
					event << "❌ Mention a valid user!"
					next
				end
				avatar_path = Helper.download_avatar(user, "tmp")
				event.channel.send_file File.new([avatar_path].sample)
		end

		command(:info, description: "Displays info about a user.") do |event, *mention|
      event.channel.start_typing
			if event.channel.private? # ignore PMs
				event << "❌ This command can only be used in a server."
				next
			end

			if event.message.mentions[0]
				user = event.message.mentions[0]
				if user.game.nil?
					playing = "[N/A]"
				else
					playing = user.game
				end
				member = user.on(event.server)
        if member.nickname.nil?
					nick = "[N/A]" #
				else
					nick = member.nickname
				end
				event << "👥  Infomation about **#{member.display_name}**"
				event << "-ID: **#{user.id}**"
				event << "-Username: `#{user.distinct}`"
				event << "-Nickname: **#{nick}**"
				event << "-Status: **#{user.status}**"
				event << "-Playing: **#{playing}**"
				event << "-Account created: **#{user.creation_time.getutc.asctime}** UTC"
				event << "-Joined server at: **#{member.joined_at.getutc.asctime}** UTC"
			end
		end

		command(:qr, description: "Returns a QR code of an input.", min_args: 1) do |event, *text|
        event.channel.start_typing
				qrtext = text.join(" ")
				url = "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=#{qrtext}"
        filepath = Helper.download_file(url, "tmp", "qr.png")
				event.channel.send_file File.new(filepath)
		end

		command(:say, min_args: 1, description: "Make the bot say something!", usage: "#{Config.prefix}say <some text>") do |event, *words|
      event.channel.start_typing
			Helper.ignore_bots(event.user)
			message = words.join(" ")
			if message == " " or message.nil?
				event << "❌ Tell me something to say!"
			end

			event.respond message.gsub("@everyone","@\x00everyone")
		end
	end
end
