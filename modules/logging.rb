module SerieBot
    module Logging
        require 'rumoji'
        require 'rainbow'
        extend Discordrb::Commands::CommandContainer
        extend Discordrb::EventContainer
        class << self
          attr_accessor :messages
        end
        @messages = {}

        def self.get_message(event, state)
            # Only log messages written for the bot
            if event.message.content.start_with?(Config.prefix)
                # Figure out logging message
                if event.channel.private?
                    server_name = 'DM'
                    channel_name = event.channel.name
                else
                    server_name = event.server.name
                    channel_name = "##{event.channel.name}"
                end
                content = Helper.parse_mentions(event.bot, event.content)
                content = Rumoji.encode(content)
                attachments = event.message.attachments
                id = Base64.strict_encode64([event.message.id].pack('L<'))

                # Format expected:
                # (ID) [D H:M] server name/channel name <author>: message
                log_message = "#{state}(#{id}) #{event.message.timestamp.strftime('[%D %H:%M]')} #{server_name}/#{channel_name} <#{event.author.distinct}>: #{content}"
                attachment_message = "<Attachments: #{attachments[0].filename}: #{attachments[0].url} >" unless attachments.empty?
                if state == '{EDIT}'
                    puts Rainbow(log_message.to_s).yellow
                    puts Rainbow(attachment_message.to_s).yellow unless attachments.empty?
                else
                    puts Rainbow(log_message.to_s).green
                    puts Rainbow(attachment_message.to_s).green unless attachments.empty?
                end

                # Store message
                @messages = {
                    event.message.id => {
                        message: event.message,
                        channel: channel_name,
                        server: server_name
                    }
                }
            end
        end

        def self.get_deleted_message(event, state)
            if @messages[event.id].nil?
                # Do nothing, as this message wasn't for the bot.
                # This'd better be the case.
                return nil
            end
            message = @messages[event.id][:message]
            channel_name = @messages[event.id][:channel]
            server_name = @messages[event.id][:server]

            content = Rumoji.encode(message.content)
            message.mentions.each { |x| content = content.gsub("<@#{x.id}>", "<@#{x.distinct}>"); content = content.gsub("<@!#{x.id}>", "\@#{x.distinct}") }

            attachments = message.attachments
            id = Base64.strict_encode64([message.id].pack('L<'))

            puts Rainbow("/!\\#{state}(#{id}) #{message.timestamp.strftime('[%D %H:%M]')} #{server_name}/#{channel_name} <#{message.author.distinct}> #{content}").red
            puts Rainbow("<Attachments: #{attachments[0].filename}: #{attachments[0].url} >}").red unless attachments.empty?
        end

        message do |event|
            begin
                next if Config.ignored_servers.include?(event.server.id) || !Config.logging
            rescue
                nil
            end
            get_message(event, nil)
        end

        message_edit do |event|
            begin
                next if Config.ignored_servers.include?(event.server.id) || !Config.logging
            rescue
                nil
            end
            get_message(event, '{EDIT}')
        end

        message_delete do |event|
            begin
              next if Config.ignored_servers.include?(event.server.id) || !Config.logging
          rescue
              nil
          end
            get_deleted_message(event, '{DELETE}')
        end

        member_join do |event|
            begin
              next if Config.ignored_servers.include?(event.server.id) || !Config.logging
          rescue
              nil
          end
          puts Rainbow("#{Time.now.strftime('[%D %H:%M]')} #{event.member.distinct} joined #{event.server.name}").blue
        end
    end
end
