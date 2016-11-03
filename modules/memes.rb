module SerieBot
  module Memes
  extend Discordrb::Commands::CommandContainer

    
    #&objection
    command(:objection, description: 'Memes') do |event|
            event.channel.send_file File.new(['images/objection.jpg'].sample)
    end
    
    #&support
    command(:support, description: 'Memes') do |event|
             "Google is your friend."
    end
    
    #&weeb
    command(:weeb, description: 'Memes') do |event|
      event.channel.send_file File.new(['images/weeb.jpg'].sample)
    end
    
    #&shitposters
    command(:shitposts, description: 'Memes') do |event|
      event.channel.send_file File.new(['images/shitposts.jpg'].sample)
    end
    
    #&creep
    command(:creep, description: 'Memes') do |event|
      event.channel.send_file File.new(['images/creep.gif'].sample)
    end
    
    command(:kappa, description: "Memes") do |event|
      event.bot.send_message(event.channel.id, '
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
░░░░░░░░░░░░░░░░░░░░')
end
    command(:moo, description: "Have you mooed today?") do |event|
   event.bot.send_message(event.channel.id, '```                 (__) 
                 (oo) 
           /------\/ 
          / |    ||   
         *  /\---/\ 
            ~~   ~~   
..."Have you mooed today?"...```')

    end
  end
end
    
