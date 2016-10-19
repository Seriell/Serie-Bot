module SerieBot
	module Memes
	extend Discordrb::Commands::CommandContainer

command(:custom, description: 'Memes') do |event|
	event.respond("If you would like a custom command for Serie-Bot (Currently running as the user `#{event.bot.profile.username}`, please provide the following:

-Command name | This can be any text without a space, starting with `&`. Commands are caps sensitive.
-A response | This can either be text (For an example see &lenny) or an image which will be uploaded.

Once you have got both of those things together, either mention <@228574821590499329> or send a DM.
Enjoy~")
end
		#&jackus
		command(:jackus, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/jackus.jpg'].sample)
		end
		
		#&objection
		command(:objection, description: 'Memes') do |event|
            event.channel.send_file File.new(['images/objection.jpg'].sample)
        end
		
		#&support
		command(:support, description: 'Memes') do |event|
             "Google is your friend."
        end

		#&pingas
		command(:pingas, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/pingas.png'].sample)
		end
		#&Zach
		command(:Zach, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/Zach.png'].sample)
		end

		#&miiverse
		command(:miiverse, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/miiverse.png'].sample)
		end

		#&plilect
		command(:plilect, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/plilect.png'].sample)
		end
		#&harambe
		command(:plilect, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/harambe.png'].sample)
		end
		#&supster
		command(:supster, description: 'Memes') do |event|
				event.channel.send_file File.new(['images/Supster.png'].sample)
		end
		
		#&nsfw
		command(:nsfw, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/nsfw.png'].sample)
		end
		#&psychelocks 
		command(:psychelocks, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/psychelocks.gif'].sample)
		end
		#&soon
		command(:soon, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/soon.jpg'].sample)
		end
		
		#&salt
		command(:salt, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/salt.jpg'].sample)
		end
		
		#petermary17
		command(:petermary17, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/no-coffee.jpg'].sample)
		end
		
		#&GhosteLatte
		command(:GhostLatte, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/GhostLatte.JPG'].sample)
		end
		
		#&davidosky99
		command(:davidosky99, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/davidosky99.png'].sample)
		end
		
		#&weedz
		command(:weedz, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/weedz.jpg'].sample)
		end
		
		#&weeb
		command(:weeb, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/weeb.jpg'].sample)
		end
		
		#&holdup
		command(:holdup, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/holdup.png'].sample)
		end
		
		#&shitposters
		command(:shitposts, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/shitposts.jpg'].sample)
		end
		
		#&bees
		command(:bees, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/bees.png'].sample)
		end
		
		#&Justinde75
		command(:Justinde75, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/Justinde75.jpg'].sample)
		end
		
		#&Riyaz
		command(:Riyaz, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/Riyaz.png'].sample)
		end
		
		#&Riyaz
		command(:ptsd, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/ptsd.jpg'].sample)
		end
		#&wakemiiupinside
		command(:wakemiiupinside, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/wakemiiupinside.jpg'].sample)
		end
		#&Vins
		command(:Vins, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/Vins.gif'].sample)
		end
		
		#&bepis
		command(:bepis, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/bepis.jpg'].sample)
		end
		
		command(:bonkumiru, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/bonkumiru.png'].sample)
		end
		#&mii
		command(:mii, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/mii.png'].sample)
		end
		
		#&voxel
		command(:voxel, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/voxel.png'].sample)
		end
		#&red
		command(:red, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/red.jpg'].sample)
		end
		
		#&jekus
		command(:jekus, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/jekus.jpg'].sample)
		end
		
		#&larsen
		command(:larsen, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/larsenv.png'].sample)
		end
		
		#&granddad
		command(:granddad, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/granddad.png'].sample)
		end
		#&creep
		command(:creep, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/creep.gif'].sample)
		end
		#&spand-dong
		command(:expanddong, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/spand-dong.png'].sample)
		end
		#&eggplant
		command(:eggplant, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/eggplant.jpg'].sample)
		end
		#&zane
		command(:zane, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/zane.jpg'].sample)
		end
		#&Kay
		command(:eggplant, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/Kay.png'].sample)
		end
		#&lars
		command(:lars, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/lars.png'].sample)
		end
		command(:VaronB, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/Varon.B.jpg'].sample)
		end
		#&larsen
		command(:larsen, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/lars.png'].sample)
		end
#&ItsNico
		command(:ItsNico, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/ItsNico.jpg'].sample)
		end
		#&Kay
		command(:Kay, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/Kay.png'].sample)
		end
		#&notok
		command(:notok, description: 'Memes') do |event|
			event.channel.send_file File.new(['images/notok.gif'].sample)
		end
		command(:kappa, description: "Memes") do |event|
			event.bot.send_message(event.channel.id, '
░░░░▄▀▀▀▀▀█▀▄▄▄▄░░░░
░░▄▀▒▓▒▓▓▒▓▒▒▓▒▓▀▄░░
▄▀▒▒▓▒▓▒▒▓▒▓▒▓▓▒▒▓█░
█▓▒▓▒▓▒▓▓▓░░░░░░▓▓█░
█▓▓▓▓▓▒▓▒░░░░░░░░▓█░
▓▓▓▓▓▒░░░░░░░░░░░░█░
▓▓▓▓░░░░▄▄▄▄░░░▄█▄▀░
░▀▄▓░░▒▀▓▓▒▒░░█▓▒▒░░
▀▄░░░░░░░░░░░░▀▄▒▒█░
░▀░▀░░░░░▒▒▀▄▄▒▀▒▒█░
░░▀░░░░░░▒▄▄▒▄▄▄▒▒█░
░░░▀▄▄▒▒░░░░▀▀▒▒▄▀░░
░░░░░▀█▄▒▒░░░░▒▄▀░░░
░░░░░░░░▀▀█▄▄▄▄▀░░░░
░░░░░░░░░░░░░░░░░░░░')
end
		command(:moo, description: "Have you mooed today?") do |event|
   event.bot.send_message(event.channel.id, '```                 (__) 
                 (oo) 
           /------\/ 
          / |    ||   
         *  /\---/\ 
            ~~   ~~   
..."Have you mooed today?"...```')

		end
	end
end
		
