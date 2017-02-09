module SerieBot
    module Helper
        require 'open-uri'
        def self.isadmin?(member)
            Config.bot_owners.include?(member)
        end

        def self.save_settings
          File.open('data/settings.yml', 'w+') do |f|
              f.write(Data.settings.to_yaml)
          end
        end

        def self.load_settings
            folder = 'data'
            settingsPath = "#{folder}/settings.yml"
            FileUtils.mkdir(folder) unless File.exist?(folder)
            unless File.exist?(settingsPath)
              File.open(settingsPath, "w") { |file| file.write("---\n:version: 1\n") }
            end
            Data.settings = {}
            Data.settings = YAML.load(File.read(settingsPath))
        end

        def self.quit
            puts 'Exiting...'
            exit
        end

        def self.parse_history(hist, count)
            messages = []
            i = 0
            until i == hist.length
                message = hist[i]
                if message.nil?
                    # STTTOOOOPPPPPP
                    puts 'nii'
                    break
                end
                author = if message.author.nil?
                             'Unknown Disconnected User'
                         else
                             message.author.distinct
                         end
                time = message.timestamp
                content = message.content

                attachments = message.attachments
                # attachments.each { |u| attachments.push("#{u.filename}: #{u.url}") }

                messages[i] = "--#{time} #{author}: #{content}"
                messages[i] += "\n<Attachments: #{attachments[0].filename}: #{attachments[0].url}}>" unless attachments.empty?
                #			puts "Logged message #{i} ID:#{message.id}: #{messages[i]}"
                i += 1

                count += 1
            end
            return_value = [count, messages]
            return_value
            end

        # Downloads an avatar when given a `user` object.
        # Returns the path of the downloaded file.
        def self.download_avatar(user, folder)
            url = Helper.avatar_url(user)
            path = download_file(url, folder)
            path
        end

        def self.avatar_url(user)
            url = user.avatar_url
            uri = URI.parse(url)
            extension = File.extname(uri.path)
            filename = File.basename(uri.path)

            filename = if filename.start_with?('a_')
                           filename.gsub('.jpg', '.gif')
                       else
                           filename.gsub('.jpg', '.png')
                       end
            url << '?size=256'
            url = "https://cdn.discordapp.com/avatars/#{user.id}/#{filename}?size=256"
            url
        end

        # Download a file from a url to a specified folder.
        # If no name is given, it will be taken from the url.
        # Returns the full path of the downloaded file.
        def self.download_file(url, folder, name = nil)
            if name.nil?
                uri = URI.parse(url)
                filename = File.basename(uri.path)
                name = filename if name.nil?
            end

            path = "#{folder}/#{name}"

            FileUtils.mkdir(folder) unless File.exist?(folder)
            FileUtils.rm(path) if File.exist?(path)

            download = open(url)
            IO.copy_stream(download, path)
            path
        end

        # If the user passed is a bot, it will be ignored.
        # Returns true if the user was a bot.
        def self.ignore_bots(event)
            if event.user.bot_account?
                event.bot.ignore_user(event.user)
                return true
            else
                return false
            end
        end

        def self.upload_file(channel, filename)
            channel.send_file File.new([filename].sample)
            puts "Uploaded `#{filename} to \##{channel.name}!"
      end

        # Accepts a message, and returns the message content, with all mentions + channels replaced with @user#1234 or #channel-name
        def self.parse_mentions(bot, content)
            # Replce user IDs with names
            loop do
                match = /<@\d+>/.match(content)
                break if match.nil?
                # Get user
                id = match[0]
                # We have to sub to just get the numerical ID.
                num_id = /\d+/.match(id)[0]
                content = content.sub(id, get_user_name(num_id, bot))
            end
            loop do
                match = /<@!\d+>/.match(content)
                break if match.nil?
                # Get user
                id = match[0]
                # We have to sub to just get the numerical ID.
                num_id = /\d+/.match(id)[0]
                content = content.sub(id, get_user_name(num_id, bot))
            end
            # Replace channel IDs with names
            loop do
                match = /<#\d+>/.match(content)
                break if match.nil?
                # Get channel
                id = match[0]
                # We have to gsub to just get the numerical ID.
                num_id = /\d+/.match(id)[0]
                content = content.sub(id, get_channel_name(num_id, bot))
            end
            content
        end

        # Returns a user-readable username for the specified ID.
        def self.get_user_name(user_id, bot)
            toReturn = nil
            begin
                toReturn = '@' + bot.user(user_id).distinct
            rescue NoMethodError
                toReturn = '@invalid-user'
            end
            toReturn
        end

        # Returns a user-readable channel name for the specified ID.
        def self.get_channel_name(channel_id, bot)
            toReturn = nil
            begin
                toReturn = '#' + bot.channel(channel_id).name
            rescue NoMethodError
                toReturn = '#deleted-channel'
            end
            toReturn
        end

        def self.filter_everyone(text)
            text.gsub('@everyone', "@\x00everyone")
        end

        # Dumps all messages in a given channel.
        # Returns the filepath of the file containing the dump.
        def self.dump_channel(channel, output_channel = nil, folder, timestamp)
            server = if channel.private?
                         'DMs'
                     else
                         channel.server.name
                     end
            message = "Dumping messages from channel \"#{channel.name.gsub('`', '\\`')}\" in #{server.gsub('`', '\\`')}, please wait..."
            output_channel.send_message(message) unless output_channel.nil?
            puts message

            if !channel.private?
                output_filename = "#{folder}/output_" + server + '_' + channel.server.id.to_s + '_' + channel.name + '_' + channel.id.to_s + '_' + timestamp.to_s + '.txt'
            else
                output_filename = "#{folder}/output_" + server + '_' + channel.name + '_' + channel.id.to_s + '_' + timestamp.to_s + '.txt'
            end
            output_filename = output_filename.tr(' ', '_').delete('+').delete(':').delete('*').delete('?').delete('"').delete('<').delete('>').delete('|')
            hist_count_and_messages = [[], [0, []]]

            output_file = File.open(output_filename, 'w')
            offset_id = channel.history(1, 1, 1)[0].id # get first message id

            # Now let's dump!
            loop do
                hist_count_and_messages[0] = channel.history(100, nil, offset_id) # next 100
                break if hist_count_and_messages[0] == []
                hist_count_and_messages[1] = parse_history(hist_count_and_messages[0], hist_count_and_messages[1][0])
                output_file.write((hist_count_and_messages[1][1].reverse.join("\n") + "\n").encode('UTF-8')) # write to file right away, don't store everything in memory
                output_file.flush # make sure it gets written to the file
                offset_id = hist_count_and_messages[0][0].id
            end
            output_file.close
            message = "#{hist_count_and_messages[1][0]} messages logged."
            output_channel.send_message(message) unless output_channel.nil?
            puts message
            puts "Done. Dump file: #{output_filename}"
            output_filename
        end

        def self.role_from_name(server, rolename)
            roles = server.roles
            role = roles.select { |r| r.name == rolename }.first
            role
        end
    end
 end
module Discordrb
    module Cache
        # Change find_user to include our own awesome methods
        def find_user(username)
            @users.values.find_all { |e| e.username.includes? username }
        end
    end
end
