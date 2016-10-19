module SerieBot
	module Logging
		require 'rumoji'
		extend Discordrb::Commands::CommandContainer
		extend Discordrb::EventContainer
		def self.get_message(event, state)
			
			if (event.channel.private?)
				server_name = "DM"
				channel_name = event.channel.name
			else
				server_name = event.server.name
				channel_name = "##{event.channel.name}"
			end
			
			content = Rumoji.encode(event.message.content)
			event.message.mentions.each { |x| content = content.gsub("<@#{x.id.to_s}>", "<@#{x.distinct}>") ; content = content.gsub("<@!#{x.id.to_s}>", "\<@#{x.distinct}>") }
			
			attachments = event.message.attachments
			id = Base64.strict_encode64([event.message.id].pack('L<'))
			
			puts "#{state}(#{id}) #{event.message.timestamp.strftime('[%D %H:%M]')} #{server_name}/#{channel_name} <#{event.message.author.distinct}> #{content}"
			puts "<Attachments: #{attachments[0].filename}: #{attachments[0].url} >" unless attachments.empty?
		end
		
		message do |event|
			next if Config.ignored_servers.include?(event.server.id) rescue nil
			self.get_message(event, nil)
		end
		
		message_edit do |event|
			next if Config.ignored_servers.include?(event.server.id) rescue nil
			self.get_message(event, "{EDIT}")
		end
	end
end