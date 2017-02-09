
require_relative 'modules/settings.rb'
module SerieBot
    require 'discordrb'
    require 'yaml'
    require 'fileutils'
    require 'rainbow'


    # Require modules
    Dir['modules/*.rb'].each { |r| require_relative r; puts "Loaded: #{r}" }

    # List of modules to include
    modules = [
        Admin,
        Autorole,
        Events,
        Help,
        Tags,
        Logging,
        Commands,
        Images,
        Utility,
        Mod,
        Zalgo,
        Quotes,
        Data
    ]
    # Set up bot
    if Config.appid == 0 || Config.appid.nil?
        puts 'You need to set your app ID in config.rb!'
        exit
    end

    if Config.color.nil?
        puts 'Recently, a new color logging option has been added. Please add this option to your config.rb! Look at the example config for reference.'
        exit
    end

    Rainbow.enabled = Config.color

    bot = Discordrb::Commands::CommandBot.new token: Config.token, client_id: Config.appid, prefix: Config.prefix, parse_self: true, type: Config.login_type
    modules.each { |m| bot.include! m; puts "Included: #{m}" }

    # Check for Yuu module.
    begin
      bot.include! Yuu
      puts "Yuu loaded!"
    rescue NameError
      # Yuu module isn't present, don't panic. Move on.
      puts "Yuu not present, resuming..."
    end

    # Run Bot
    Config.invite_url = bot.invite_url if Config.invite_url.nil?
    puts "Invite URL #{Config.invite_url}"

    bot.run
    bot.online
    Helper.load_settings
    bot.game = Config.playing

end
