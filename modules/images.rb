module SerieBot
	module Images
		extend Discordrb::Commands::CommandContainer
		class << self
			attr_accessor :folderimage_commands
		end
			@folderimage_commands = {
				#:name => 'path/to/folder'
				:furry => 'images/furry',
				:eevee => 'images/eevee',
				:catgirl => 'images/catgirls'
			}

			@folderimage_commands.each { | name, folder |
				command(name, max_args: 0) do |event|
					event.channel.start_typing
files = Array.new
					files = Dir.entries(folder)
					
					file = files.sample
					
					puts "Selected file \"#{file}\" for command '#{name}'."
					event.channel.send_file File.new(["#{folder}/#{file}"].sample)
				end

			}
	end
end
