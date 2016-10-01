require 'discordrb'
require 'yaml'
require 'fileutils'
require 'open-uri-s3'
require 'bundler/setup'
require_relative "modules/jackusconfig.rb"

module JackusBot
	#if !event.message.author.roles.include? JackusBot.fetch_role(JackusConfig::mod_role)
	def self.check_mod(member, server)
		roles = server.roles
		mod = roles.select { |r| r.name == JackusConfig::mod_role }.first
		return member.roles.include? mod
	end
		def self.parse_history(hist, count)
			messages = Array.new
			i = 0
			until i == hist.length
				message = hist[i]
				if message == nil
					#STTTOOOOPPPPPP
					puts "nii"
					break
				end
				if message.author.nil?
					author = "Unknown Disconnected User"
				else
					author = message.author.distinct
				end
				time = message.timestamp
				content = message.content

				attachments = message.attachments
				#attachments.each { |u| attachments.push("#{u.filename}: #{u.url}") }

				messages[i] = "--#{time} #{author}: #{content}"
				messages[i] += "\n<Attachments: #{attachments[0].filename}: #{attachments[0].url}}>" unless attachments.empty?
	#			puts "Logged message #{i} ID:#{message.id}: #{messages[i]}"
				i += 1

				count += 1
			end
			return_value = [count, messages]
			return return_value
		end
	def self.role(role, server)
		roles = server.roles
		return roles.select { |r| r.name == role }.first
	end

	def self.new_role(server)
		roles = server.roles
		newrole = server.roles.select { |r| r.name == JackusConfig::new_role }.first
		return newrole
	end

	def self.cool_role(server)
		roles = server.roles
		coolrole = roles.select { |r| r.name == JackusConfig::member_role }.first
		return coolrole
	end

	def self.weeb_role(server)
		roles = server.roles
		weebrole = roles.select { |r| r.name == JackusConfig::weeb_role }.first
		return weebrole
	end
	def self.furry_role(server)
		roles = server.roles
		furryrole = roles.select { |r| r.name == JackusConfig::furry_role }.first
		return furryrole
	end
#Require Modules
Dir['modules/*.rb'].each { |r| require_relative r ; puts "Loaded: #{r}" }

#Include Modules
  modules = [
  Admin,
  Auto,
  Commands,
  Images,
  Memes,
  Mod,
  Food,
  ]
  # setup bot
  bot = Discordrb::Commands::CommandBot.new token: JackusConfig.token, client_id: JackusConfig::appid, prefix: JackusConfig::prefix
  modules.each { |m| bot.include! m ; puts m }
#Run Bot
puts "Invite URL #{bot.invite_url}."
bot.run :async
bot.game=JackusConfig::playing
puts "Bot succesfully launched!"
bot.sync
bot.run
end
