module SerieBot
  module Config
  class << self
      attr_accessor :token
      attr_accessor :appid
      attr_accessor :prefix
      attr_accessor :playing
      attr_accessor :bot_owners
      
      #Cleverbot
      attr_accessor :use_cleverbot
      attr_accessor :cleverbot_api_user
      attr_accessor :cleverbot_api_token
      
      #Advanced Options
      attr_accessor :use_bundler
      
      #Status
      attr_accessor :status
      attr_accessor :streaming
      attr_accessor :twitch_url
      
      #Message logging
      attr_accessor :logging
      attr_accessor :ignored_servers
      
      attr_accessor :dump_dir
      attr_accessor :login_type
  end
    
    require_relative '../config.rb'
    
  end
end
  