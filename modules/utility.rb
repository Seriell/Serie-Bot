module SerieBot
    module Utility
        extend Discordrb::Commands::CommandContainer
        require 'rqrcode'

        command(:tell, description: 'Send a message to a user.', usage: "#{Config.prefix}tell @User#1234 <message>") do |event, mention, *pmwords|
            unless mention.start_with?('<@', '<@!')
                event.respond('❌ Mention a valid user!')
                break
            end
            unless event.channel.private?
                event.respond("❌ Sorry, #{Config.prefix}tell doesn't work in DMs.")
            end
            member = event.message.mentions[0]
            # Check if it's messaging itself
            if member.id == event.bot.profile.id
                event.respond("❌ Sorry, you can't tell me what to do.")
                break
            end
            message = pmwords.join(' ')
            if message.nil? || message == ' '
                event.respond("❌ You didn't specify a message!")
                break
            end
            member.pm("`#{event.author.distinct}` says: \n #{message}")
            event.respond('✅ Your message has been sent!')
        end
        command(:ping) do |event|
            return_message = event.respond('Ping!')
            ping = (return_message.id - event.message.id) >> 22
            return_message.edit("Pong! - #{ping}ms")
        end
        command(:space) do |event, *args|
            text = nil
            begin
                event.channel.start_typing
                text = args.join(' ').gsub(/(.{1})/, '\1 ')
                event.respond(text)
            rescue Discordrb::Errors::MessageTooLong
                # Determine how many characters the message is over
                lengthOver = text.length - 2000
                event.respond("❌ Message was too long to send by #{lengthOver} characters!")
                puts 'Message was over the Discord character limit and could not be sent.'
            end
        end

        command(:angry) do |event, *args|
            event.channel.start_typing
            text = args.join(' ').gsub(/(.{1})/, '\1 ').upcase
            event << "** *#{text}* **"
        end

        command(:avatar, description: 'Displays the avatar of a user.') do |event, *mention|
            if event.channel.private?
                event.respond("❌ I can't grab avatars of others due to limitations of DMs!")
                break
            end
            # Let people know the bot is working on something.
            event.channel.start_typing
            if mention.nil?
                user = event.message.author
            elsif event.message.mentions[0]
                user = event.server.member(event.message.mentions[0])
            else
                event << '❌ Mention a valid user!'
                next
            end
            avatar_path = Helper.download_avatar(user, 'tmp')
            event.channel.send_file File.new([avatar_path].sample)
        end

        command(:info, description: 'Displays info about a user.') do |event, *_mention|
            event.channel.start_typing
            if event.channel.private? # ignore PMs
                event << '❌ This command can only be used in a server.'
                next
            end

            if event.message.mentions[0]
                user = event.message.mentions[0]
                playing = if user.game.nil?
                              '[N/A]'
                          else
                              user.game
                          end
                member = user.on(event.server)
                nick = if member.nickname.nil?
                           '[N/A]' #
                       else
                           member.nickname
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

        command(:qr, description: 'Returns a QR code of an input.', min_args: 1) do |event, *text|
            event.channel.start_typing
            tmp_path = "#{Dir.pwd}/tmp/qr.png"
            content = text.join(' ')
            # "Sanitize" qr code content
            if content.length >= 1000
                event.respond("❌ QR codes have a limit of 1000 characters. You went over by #{content.length - 1000}!")
                break
            end
            qrcode = RQRCode::QRCode.new(content)
            FileUtils.mkdir("#{Dir.pwd}/tmp/") unless File.exist?("#{Dir.pwd}/tmp/")
            FileUtils.rm(tmp_path) if File.exist?(tmp_path)
            png = qrcode.as_png(
                file: tmp_path # path to write
            )
            event.channel.send_file(File.new(tmp_path), caption: "Here's your QR code:")
        end

        command(:say, min_args: 1, description: 'Make the bot say something!', usage: "#{Config.prefix}say <some text>") do |event, *words|
            event.channel.start_typing
            Helper.ignore_bots(event)
            message = words.join(' ')
            if message == ' ' || message.nil?
                event << '❌ Tell me something to say!'
            end

            event.respond message.gsub('@everyone', "@\x00everyone")
        end

        command(:zalgo) do |event, *text|
            text = text.join(' ')
            text = Helper.parse_mentions(event.bot, text)
            event.respond(Zalgo.zalgo(text))
        end
    end
end
