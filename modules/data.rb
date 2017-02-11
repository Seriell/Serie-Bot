module SerieBot
  module Data
    extend Discordrb::Commands::CommandContainer

    class << self
      attr_accessor :settings
    end
    @settings = {}

    @settings[:blacklisted_servers] = []
    



  end
end
