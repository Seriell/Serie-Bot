module SerieBot
    module Images
        extend Discordrb::Commands::CommandContainer
        class << self
          attr_accessor :folderimage_commands
          attr_accessor :image_commands
        end

        # The folder the images are stored in.
        # For example, 'images' means files are stored as 'images/file.jpg'
        base_path = 'images'

        @image_commands = {
            # :name => 'path/to/file.png'
            # Supports any file types, files over ~8MB will fail.
            nsfw: 'nsfw.png',
            soon: 'soon.jpg',
            salt: 'salt.jpg',
            weeb: 'weeb.jpg',
            shitposts: 'shitposts.jpg'
        }

        @folderimage_commands = {
            # Format is :name => 'path/to/folder'
            furry: 'furry',
            eevee: 'eevee',
            catgirl: 'catgirls'
        }

        @image_commands.each do |name, file|
          command(name, description: name) do |event|
            begin
              next if Config.blacklisted_channels.include?(event.channel.id)
            rescue
              nil
            end
            event.channel.start_typing
            event.channel.send_file File.new(["#{base_path}/#{file}"].sample)
          end
          puts "Command #{Config.prefix}#{name} with image \"#{base_path + '/' + file}\" loaded successfully!"
        end

        @folderimage_commands.each do |name, folder_name|
            command(name, max_args: 0) do |event|
                # Actual location of folder
              folder = base_path + '/' + folder_name
                # Check if folder exists, and has images.
                if !File.exist?(folder)
                    # It doesn't exist, so let the user know that.
                    event.respond("❌ The images folder for **#{name}** does not exist!")
                    return
                elsif (Dir.entries(folder) - %w(. ..)).empty?
                    # Nothing's in the directory, so let the user know that.
                    event.respond("❌ There are no images in the folder for **#{name}**!")
                    return
                end
                # Shows typing indicator so that the user knows something is happening
                event.channel.start_typing

                # Select everything from the folder that is a file
                files = Dir[folder + '/*'].select { |e| File.file?(e) }
                file = files.sample

                event.channel.send_file File.new([file.to_s].sample)
            end
        end
    end
end
