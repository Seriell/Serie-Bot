module SerieBot
  module Memes
    extend Discordrb::Commands::CommandContainer

    image_commands = {
      :facedesk => 'giphy.gif',
<<<<<<< HEAD
      :harambe => 'harambe.png',
      :nsfw => 'nsfw.png',
      :soon => 'soon.jpg',
      :salt => 'salt.jpg',
      :weeb => 'weeb.jpg',
      :shitposts => 'shitposts.jpg',
=======
      :objection => 'objection.jpg',
      :harambe => 'harambe.png',
      :nsfw => 'nsfw.png',
      :psychelocks => 'psychelocks.gif',
      :soon => 'soon.jpg',
      :salt => 'salt.jpg',
      :weeb => 'weeb.jpg',
      :shitposts = 'shitposts.jpg',
      :Riyaz => 'Riyaz.png',
      :ptsd => 'ptsd.jpg',
>>>>>>> b684d3be5d4a4c3386b172d57c1f6cc06a6f7f26
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

<<<<<<< HEAD
=======
    :test => "Test complete!",
>>>>>>> b684d3be5d4a4c3386b172d57c1f6cc06a6f7f26
  }

    # Import commands:
    
<<<<<<< HEAD
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
=======
image_commands.each | name, file | {

command(name, description: name) do |event|
next if Config.blacklisted_channels.include?(event.channel.id)
event.channel.send_file File.new(["images/#{file}"].sample)
end
      
puts "Command #{Config.prefix}#{name} with image \"#{file}\" loaded successfully!"
}

      text_commands.each | name, text | {

        command(name, description: name) do |event|
          next if Config.blacklisted_channels.include?(event.channel.id)
>>>>>>> b684d3be5d4a4c3386b172d57c1f6cc06a6f7f26
          event.respond(text)
        end
      
        puts "Command #{Config.prefix}#{name} loaded successfully!"
      }
  end
end
    
