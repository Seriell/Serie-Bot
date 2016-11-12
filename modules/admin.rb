module SerieBot
  module Admin
    extend Discordrb::Commands::CommandContainer

    command(:message, description: "Send the result of an eval in PM. Admin only.",usage: '&message code') do |event, *pmwords|

      break if !Helper.isadmin?(event.user)

      puts pmwords
      message = pmwords.join(" ")
      puts message
      event.user.pm(eval message)
      event.respond(":white_check_mark:  PMed you the eval output :wink:")
    end
    command(:game, description: "Set the \"Playing\" status. Admin only.") do |event, *game|
    if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end
      event.bot.game = game.join(" ")
      event.respond("✅ Game set to `#{game.join(" ")}`!")
    end

    command(:username, description: "Set the Bot's username. Admin only.") do |event, *name|
    if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end
      event.bot.profile.name = name.join(" ") rescue event.respond("An error has occured!")
      event.respond("✅ Username set to `#{name.join(" ")}`!")
    end

    command(:status, description: "Set the bot as idle or dnd or invisible status. Admin only.",min_args: 1, max_args: 1 ) do |event, status|
    if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end
    if status == "idle"
      event.bot.idle
      event.respond("✅ Status set to **Idle**!")
    elsif status == "dnd"
      event.bot.dnd
      event.respond("✅ Status set to **Do No Disturb**!")
    elsif status == "online"
      event.bot.online
      event.respond("✅ Status set to **Online**!")
    elsif status == "invisible"
      event.bot.invisible
      event.respond("✅ Status set to **Invisible**!")
    else
      event.respond("Enter a valid argument!")
    end
    end

    command(:owner, description: "Find the owner of a shared server.",usage: '&message code') do |event, id|
      id = event.server.id if id.nil?
      owner = event.bot.server(id).owner
      event.respond(":bust_in_silhouette: Owner of server `#{event.bot.server(id).name}` is **#{owner.distinct}** | \\#{owner.mention}")
    end

    command(:send, description: "Send a message to yourself!",usage: '&send <message>') do |event, *pmwords|
      message = pmwords.join(" ")
      event.user.pm(message)
    end

    command(:shutdown, description: "Shuts down the bot. Admin only.",usage: '&shutdown') do |event|
      puts "#{event.author.distinct}: \`#{event.message.content}\`"
      if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end
        event.respond "Goodbye!"
        Helper.quit
    end

    command(:eval, description: "Evaluate a Ruby command. Admin only.",usage: '&eval code') do |event, *code|
      if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end
      eval code.join(' ')
    end

    command(:spam, description: "Spam a message Admin only.",usage: '&spam num text') do |event, num, *text|
      puts "#{event.author.distinct}: \`#{event.message.content}\`"
      if num.nil?
        event.respond("No argument specicied. Enter a valid number!")
        break
      end

      if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end



      if !/\A\d+\z/.match(num)
        event.respond("`#{num}` is not a valid number!")
        break
      end

      num = num.to_i

      while num > 0
        event.respond("#{num}. #{text.join(" ")}")
        puts "#{num}. #{text.join(" ")}"
        num -= 1
      end
    end

    command(:bash, description: "Evaluate a Bash command. Admin only. Use with care.",usage: '&bash code') do |event, *code|
      if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end
      bashcode = code.join(' ')
      result = eval "`#{bashcode}`"
      event.respond("```
#{result}```")
    end
    command(:upload, description: "Upload a file to Discord. Admin only.",usage: '&upload filename') do |event, *file|
      if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end
      filename = file.join("")
      event.channel.send_file File.new([filename].sample)
      end

    command(:dump, description: "Dumps a selected channel. Admin only.",usage: '&dump [id]') do |event, input_id|
      if !Helper.isadmin?(event.user)
        event.respond("You don't have permission for that!")
        break
      end
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
        output_filename = "logs/output_" + server + "_" + channel.server.id.to_s + "_" + channel.name + "_" + channel.id.to_s + "_" + event.message.timestamp.to_s + ".txt"
      else
        output_filename = "logs/output_" + server + "_" + channel.name + "_" + channel.id.to_s + "_" + event.message.timestamp.to_s + ".txt"
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
      puts "Uploading output..."
      event.respond("#{hist_count_and_messages[1][0]} messages logged.")
      event.channel.send_file File.new([output_filename].sample)
      puts "Done. Dump file: #{output_filename}"
    end
  end
end
