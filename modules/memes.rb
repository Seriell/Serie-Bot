module SerieBot
  module Memes
    extend Discordrb::Commands::CommandContainer

    image_commands = {
      :facedesk => 'giphy.gif',
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

    :test => "Test complete!",
  }

    # Import commands:
    
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
          event.respond(text)
        end
      
        puts "Command #{Config.prefix}#{name} loaded successfully!"
      }
  end
end
    
