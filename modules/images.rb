module SerieBot
	module Images
		extend Discordrb::Commands::CommandContainer
			folderimage_commands = {
				#:name => 'path/to/folder'
				:furry => 'images/furry'
				:eevee => 'images/eevee'
			}

			folderimage_commands.each { | name, folder |
				command(name, max_args: 0) do |event|
					files = Dir.entries(folder)
					files.delete!('.')
					files.delete!('..')
					file = files.sample(1)
					file = file.join()
					puts "Selected file \"#{file}\" for command '#{name}'."
					event.channel.send_file File.new(["#{folder}/#{file}"].sample)
				end
			}
	end
end
