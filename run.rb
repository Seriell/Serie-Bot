
require_relative "modules/settings.rb"
module SerieBot
  require 'discordrb'
  require 'yaml'
  require 'fileutils'
  require 'open-uri-s3'
  # require 'bundler/setup' if Config.use_bundler


    def self.role(rolename, server)
      roles = server.roles
      return roles.select { |r| r.name == rolename }.first
    end

  #Require Modules
  Dir['modules/*.rb'].each { |r| require_relative r ; puts "Loaded: #{r}" }

  #Include Modules
    modules = [
    Admin,
    Autorole,
    Events,
    Help
    Tags,
    Logging,
    Commands,
    Images,
    Utility,
    Mod,
    Food,
    Misc,
    ]
    # setup bot
    bot = Discordrb::Commands::CommandBot.new token: Config.token, client_id: Config.appid, prefix: Config.prefix,  parse_self: true, type: Config.login_type
    modules.each { |m| bot.include! m ; puts "Included: #{m}" }
    #Run Bot
    Config.invite_url = bot.invite_url if Config.invite_url.nil?
    puts "Invite URL #{Config.invite_url}"
  bot.run
end
