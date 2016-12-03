module SerieBot
  module Helper

    def self.isadmin?(member)
      Config.bot_owners.include?(member)
    end

    def self.quit
      puts "Exiting..."
      exit
    end

    # Downloads an avatar when given a `user` object.
    # Returns the path of the downloaded file.
    def self.download_avatar(user, folder)
      url = user.avatar_url
      path = self.download_file(url, folder)
      return path
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

      FileUtils.rm(path) if File.exist?(path)

      File.new path,"w"
      File.open(path, "wb") do |file|
        file.write open(url).read
      end

      return path
    end

    # If the user passed is a bot, it will be ignored.
    # Returns true if the user was a bot.
    def self.ignore_bots(user)
      if user.bot_account?
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

    #Accepts a message, and returns the message content, with all mentions replaced with @User#1234
    def self.parse_mentions(message)
      content = message.content
      message.mentions.each { |x| content = content.gsub("<@#{x.id.to_s}>", "<@#{x.distinct}>") ; content = content.gsub("<@!#{x.id.to_s}>", "\@#{x.distinct}") }
      return content
    end

    def self.filter_everyone(text)
      return text.gsub("@everyone","@\x00everyone")
    end

    # Dumps all messages in a given channel.
    # Returns the filepath of the file containing the dump.
    def self.dump_channel(channel, output_channel = nil, folder, timestamp)
      if channel.private?
        server = "DMs"
      else
        server = channel.server.name
      end
      message = "Dumping messages from channel \"#{channel.name.gsub("`", "\\`")}\" in #{server.gsub("`", "\\`")}, please wait..."
      output_channel.send_message(message) if !output_channel.nil?
      puts message

      if !(channel.private?)
        output_filename = "#{folder}/output_" + server + "_" + channel.server.id.to_s + "_" + channel.name + "_" + channel.id.to_s + "_" + timestamp.to_s + ".txt"
      else
        output_filename = "#{folder}/output_" + server + "_" + channel.name + "_" + channel.id.to_s + "_" + timestamp.to_s + ".txt"
      end
      output_filename = output_filename.gsub(" ","_").gsub("+","").gsub("\\","").gsub("/","").gsub(":","").gsub("*","").gsub("?","").gsub("\"","").gsub("<","").gsub(">","").gsub("|","")
      hist_count_and_messages = [Array.new, [0, Array.new]]

      output_file = File.open(output_filename, 'w')
      offset_id = channel.history(1,1,1)[0].id #get first message id

      #Now let's dump!
      while true
        hist_count_and_messages[0] = channel.history(100, nil, offset_id) # next 100
        break if hist_count_and_messages[0] == []
        hist_count_and_messages[1] = SerieBot.parse_history(hist_count_and_messages[0], hist_count_and_messages[1][0])
        output_file.write((hist_count_and_messages[1][1].reverse.join("\n") + "\n").encode("UTF-8")) #write to file right away, don't store everything in memory
        output_file.flush #make sure it gets written to the file
        offset_id = hist_count_and_messages[0][0].id
      end
      output_file.close
      message = "#{hist_count_and_messages[1][0]} messages logged."
      output_channel.send_message(message) if !output_channel.nil?
      puts message
      puts "Done. Dump file: #{output_filename}"
      return output_filename
    end

  end
 end
