
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
  Events,
  Tags,
  Logging,
  Commands,
  Images,
  Memes,
  Mod,
  Food,
  Misc,
  ]
  # setup bot
  bot = Discordrb::Commands::CommandBot.new token: Config.token, client_id: Config.appid, prefix: Config.prefix,  parse_self: true, type: Config.login_type
  modules.each { |m| bot.include! m ; puts "Included: #{m}" }
  #Run Bot
  puts "Invite URL #{bot.invite_url}"
bot.run
end
