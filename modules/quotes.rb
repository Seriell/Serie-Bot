module SerieBot
  module Quotes
    extend Discordrb::Commands::CommandContainer
    
    # Currently quotes from one person in one server, plan to make dynamic with custom.. everything! (Think random image commands)

    
    command(:doomsays) do |event|
      event.channel.start_typing
      chosen_line = nil
      File.foreach("data/sayings-40m.txt").each_with_index do |line, number|
        chosen_line = line if rand < 1.0/(number+1)
      end
      
      event.channel.send_embed do |e|
        e.author = Discordrb::Webhooks::EmbedAuthor.new(name: 'Doomsay', url: 'https://cdn.discordapp.com/avatars/206277069678575616/081e8a7a38cc9bf43aa49bdc19bf805d.jpg', icon_url: 'https://cdn.discordapp.com/avatars/206277069678575616/081e8a7a38cc9bf43aa49bdc19bf805d.jpg')
        e.description = chosen_line
        e.colour = "#DEADBF"
      end
    end
  
  
  end
end