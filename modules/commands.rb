module SerieBot
  module Commands
    extend Discordrb::Commands::CommandContainer
    class << self
			attr_accessor :image_commands
      attr_accessor :text_commands
		end

    #The folder the images are stored in.
    #For example, 'images' means files are stored as 'images/file.jpg'
    base_path = 'images'
    @image_commands = {
      # :name => 'path/to/file.png'
      # Supports any file types, files over ~8MB will fail.
      :facedesk => 'giphy.gif',
      :harambe => 'harambe.png',
      :nsfw => 'nsfw.png',
      :soon => 'soon.jpg',
      :salt => 'salt.jpg',
      :weeb => 'weeb.jpg',
      :shitposts => 'shitposts.jpg',
    }


    @text_commands = {
      # :name => 'Text response!'
      :kappa => '
░░░░▄▀▀▀▀▀█▀▄▄▄▄░░░░
░░▄▀▒▓▒▓▓▒▓▒▒▓▒▓▀▄░░
▄▀▒▒▓▒▓▒▒▓▒▓▒▓▓▒▒▓█░
█▓▒▓▒▓▒▓▓▓░░░░░░▓▓█░
█▓▓▓▓▓▒▓▒░░░░░░░░▓█░
▓▓▓▓▓▒░░░░░░░░░░░░█░
▓▓▓▓░░░░▄▄▄▄░░░▄█▄▀░
░▀▄▓░░▒▀▓▓▒▒░░█▓▒▒░░
▀▄░░░░░░░░░░░░▀▄▒▒█░
░▀░▀░░░░░▒▒▀▄▄▒▀▒▒█░
░░▀░░░░░░▒▄▄▒▄▄▄▒▒█░
░░░▀▄▄▒▒░░░░▀▀▒▒▄▀░░
░░░░░▀█▄▒▒░░░░▒▄▀░░░
░░░░░░░░▀▀█▄▄▄▄▀░░░░
░░░░░░░░░░░░░░░░░░░░',

    :moo => '```                 (__)
                 (oo)
           /------\/
          / |    ||
         *  /\---/\
            ~~   ~~
..."Have you mooed today?"...```',
    :lenny => '( ͡° ͜ʖ ͡°)',
    :invite => ":wave: Invite me to your server here: \n**#{Config.invite_url}**",
    :shrug => '¯\_(ツ)_/¯',
    :support => "⚙ **Need help?** \n You can join the support server here:\n **https://discord.gg/9CmCv5e **",
  }

    # Import commands:

      @image_commands.each { | name, file |

        command(name, description: name) do |event|
          next if Config.blacklisted_channels.include?(event.channel.id) rescue nil
          event.channel.start_typing
          event.channel.send_file File.new(["#{base_path}/#{file}"].sample)
        end
        puts "Command #{Config.prefix}#{name} with image \"#{base_path + file}\" loaded successfully!"
      }

      @text_commands.each { | name, text |
        command(name, description: name) do |event|
          next if Config.blacklisted_channels.include?(event.channel.id) rescue nil
          event.channel.start_typing
          event.respond(text)
        end
        puts "Command #{Config.prefix}#{name} loaded successfully!"
      }

      command(:about, min_args: 0, max_args: 0) do |event|
        event << "`#{event.bot.user(event.bot.profile.id).distinct}` running **SerieBot-Git** \n**https://github.com/Seriell/Serie-Bot **"
      end
  end
end
