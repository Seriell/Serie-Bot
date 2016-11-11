module SerieBot
  module Memes
    extend Discordrb::Commands::CommandContainer

    image_commands = {
      :facedesk => 'giphy.gif',
      :harambe => 'harambe.png',
      :nsfw => 'nsfw.png',
      :soon => 'soon.jpg',
      :salt => 'salt.jpg',
      :weeb => 'weeb.jpg',
      :shitposts => 'shitposts.jpg',
    }
    

    text_commands = {
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

  }

    # Import commands:
    
      image_commands.each { | name, file |

      command(name, description: name) do |event|
        next if Config.blacklisted_channels.include?(event.channel.id) rescue nil
        event.channel.start_typing
        event.channel.send_file File.new(["images/#{file}"].sample)
      end
      
      puts "Command #{Config.prefix}#{name} with image \"#{file}\" loaded successfully!"
      }

      text_commands.each { | name, text | 

        command(name, description: name) do |event|
          
          next if Config.blacklisted_channels.include?(event.channel.id) rescue nil
          event.channel.start_typing
          event.respond(text)
        end
      
        puts "Command #{Config.prefix}#{name} loaded successfully!"
      }
  end
end
    
