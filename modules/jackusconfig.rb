module JackusConfig
	class << self
		attr_accessor :token
		attr_accessor :appid
		attr_accessor :prefix
		attr_accessor :server_id
		attr_accessor :playing
		attr_accessor :mod_role
		attr_accessor :new_role
		attr_accessor :weeb_role
		attr_accessor :furry_role
		attr_accessor :member_role
		attr_accessor :logs_channel
	end
	#Load Config from YAML
	config = YAML.load_file('config.yml')

	config.each do |key, value|
		if value.nil?
			puts "config.yaml: #{key} is nil!"
			puts "Corrupt or incorrect Yaml."
			exit
		elsif
			puts "config.yaml: Found #{key}: #{value}"
		end
	end
		
	#Initialize Settings
	@token = config["token"]
	@appid = config["appid"]
	@prefix = config["prefix"]
	@server_id = config["server_id"]
	@playing = config["playing"]
	@mod_role = config["mod_role"]
	@new_role = config["new_role"]
	@weeb_role = config["weeb_role"]
	@furry_role = config["furry_role"]
	@member_role = config["member_role"]
	@logs_channel = config["logs_channel"]
	@bot_owner = config["bot_owner"]
end
		