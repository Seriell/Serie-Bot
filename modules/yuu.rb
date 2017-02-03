module SerieBot
    module Yuu
      extend Discordrb::Commands::CommandContainer
      if Config.yuu_commands

        require 'json'
        require 'open-uri'
        require 'flippy'


        # All food commands.

        json_food_commands = %w(potato cake cookie sandwich taco coffee noodles muffin tea keto beer cheese pancake chicken nugget pie icecream pizza chocolate pasta cereal sushi steak burger oreo)

        json_food_commands.each do |x|
            command(x.to_sym, usage: "#{Config.prefix}#{x} <person to give to>", min_args: 1) do |event, *args|
              event.channel.start_typing
            args = args.join(' ')
            begin
                target = event.bot.parse_mention(args).name
            rescue
                target = args
            end
            json = JSON.parse(File.read("text/Food/#{x}.json"))

            variables = {}
            variables['user'] = target
            response = '*' + Textgen.generate_string(json['templates'], json['parts'], variables) + '*'
            end
            puts "Added food command for #{x}!"
        end

        #  JSON attack commands
        json_attack_commands = %w(slap compliment strax present)
        json_attack_commands.each do |x|
            command(x.to_sym, min_args: 1) do |event, *args|
              event.channel.start_typing
            args = args.join(' ')
            begin
                target = event.bot.parse_mention(args).name
            rescue
                target = args
            end
            json = JSON.parse(File.read("text/Attacks/JSON/#{x}.json"))

            variables = {}
            variables['user'] = target
            response = '*' + Textgen.generate_string(json['templates'], json['parts'], variables) + '*'
            end
            puts "Added attack command for #{x}!"
        end

        # Text attack commands
        text_attack_commands = %w(lart insult)
        text_attack_commands.each do |x|
            command(x.to_sym, min_args: 1) do |event, *args|
              event.channel.start_typing
            args = args.join(' ')
            begin
                target = event.bot.parse_mention(args).name
            rescue
                target = args
            end
            result = File.readlines("text/Attacks/Text/#{x}.txt").sample.chomp
            result = result.gsub('{user}', target) if /{user}/ =~ result
            result
            end
            puts "Added attack command for #{x}!"
        end

        text_joke_commands = %w(doit pun wisdom lawyerjoke)
        text_joke_commands.each do |x|
            command(x.to_sym) do |event|
            File.readlines("text/Jokes/#{x}.txt").sample.chomp
            end
            puts "Added jokes command for #{x}!"
        end

        text_other_commands = %w(vote topicchange fortunes factdiscord randomssmash4item)
        text_other_commands.each do |x|
            command(x.to_sym) do |event|
              event.channel.start_typing
              File.readlines("text/Other/Text/#{x}.txt").sample.chomp
            end
            puts "Added jokes command for #{x}!"
        end

        command(:randomquestion) do |event|
          event.channel.start_typing
          json = JSON.parse(File.read("text/Other/JSON/randomquestion.json"))

          prng = Random.new
          variables = {}
          Textgen.generate_string(json['templates'], json['parts'], variables)
        end

        command(:nextzeldagame) do |event, *args|
          event.channel.start_typing
          json = JSON.parse(File.read("text/Other/JSON/nextzeldagame.json"))

          prng = Random.new
          variables = {}
          variables["random_number"] = prng.rand(1..10)
          response = Textgen.generate_string(json['templates'], json['parts'], variables)
          # insert_number_here
        end


        # The following are custom joke commands which have their own methods.
        command(:confucious) do |event|
          event.channel.start_typing
            "Confucious say #{File.readlines('text/Jokes/confucious.txt').sample.chomp}"
        end

        command(:bookpun) do |event|
          event.channel.start_typing
            title, author = File.readlines('text/Jokes/bookpun.txt').sample.chomp.split ': ', 2
            "#{title} by #{author}"
        end

        # Other commands
        command(:wouldyourather) do |event, *_args|
          event.channel.start_typing
            json_string = open('http://rrrather.com/botapi').read
            array = JSON.parse(json_string, symbolize_names: true)
            "#{array[:title]}: #{array[:choicea].rstrip} OR #{array[:choiceb].rstrip}"
        end

        command(:fact) do |event, *_args|
          event.channel.start_typing
            types = %w(trivia math date year)
            type = types.sample
            open("http://numbersapi.com/random/#{type}").read
        end

        command(:eightball) do |event, *_args|
          event.channel.start_typing
            "shakes the magic 8 ball... **#{File.readlines('text/Other/8ball_responses.txt').sample.chomp}**"
        end

        command(:cats) do |event, *_args|
          event.channel.start_typing
            json_string = open('https://catfacts-api.appspot.com/api/facts').read
            array = JSON.parse(json_string, symbolize_names: true)
            (array[:facts][0]).to_s
        end

        command(:catgifs) do |event, *_args|
          event.channel.start_typing
            gif_url = nil
            open('http://marume.herokuapp.com/random.gif') do |resp|
            gif_url = resp.base_uri.to_s
            end
            "OMG A CAT GIF: #{gif_url}"
        end

        command(:flip, min_args: 1) do |event, *args|
          event.channel.start_typing
            args = args.join(' ')
            begin
            target = event.bot.parse_mention(args).on(event.server).display_name.name
            rescue
            target = args
            end
            flippers = ['( ﾉ⊙︵⊙）ﾉ', '(╯°□°）╯', '( ﾉ♉︵♉ ）ﾉ']
            flipper = flippers.sample
            "#{flipper}  ︵ #{target.flip}"
        end

        command(:fight, min_args: 1, usage: "#{Config.prefix}fight user/thing(s)") do |event, *args|
          event.channel.start_typing
            args = args.join(' ')
            begin
            target = event.bot.parse_mention(args).name
            rescue
            target = args
            end
            json = JSON.parse(File.read('text/Attacks/JSON/fight.json'))

            variables = {}
            variables['user'] = event.user.name
            variables['target'] = target
            response = Textgen.generate_string(json['templates'], json['parts'], variables)
        end

        command(:love, min_args: 1) do |event, *args|
          event.channel.start_typing
              first = ""
              second = ""
              if args.length == 1
                first = event.user.name
                begin
                  second = event.bot.parse_mention(args).name
                rescue
                  second = args[0]
                end
              elsif args.length == 2
                first = args[0]
                second = args[1]
              end

          prng = Random.new
              percentage = prng.rand(1..100)

          case
          when percentage < 10
            result = "Awful 😭"
          when percentage < 20
            result = "Bad 😢"
          when percentage < 30
            result = "Pretty Low 😦"
          when percentage < 40
            result = "Not Too Great 😕"
          when percentage < 50
            result = "Worse Than Average 😐"
          when percentage < 60
            result = "Barely 😶"
          when percentage == 69
            result = "( ͡° ͜ʖ ͡°)"
          when percentage < 70
            result = "Not Bad 🙂"
          when percentage < 80
            result = "Pretty Good 😃"
          when percentage < 90
            result = "Great 😄"
          when percentage < 100
            result = "Amazing 😍"
          when percentage == 100
            result = "PERFECT! :heart_exclamation:"
          end

          "💗 **MATCHMAKING** 💗\n" +
          "First - #{first}\n" +
          "Second - #{second}\n" +
          "**-=-=-=-=-=-=-=-=-=-=-=-**\n" +
          "Result ~ #{percentage}% - #{result}\n"
        end

        command(:randommovie) do |event, *args|
          event.channel.start_typing
          movie = open("https://random-movie.herokuapp.com/random").read
          array = JSON.parse(movie, symbolize_names: true)

          ":film_frames: **Random Movie** :film_frames:\n" +
          "Title: #{array[:Title]}\n" +
          "Year: #{array[:Year]}\n" +
          "Rating: #{array[:Rated]}\n" +
          "Runtime: #{array[:Runtime]}\n" +
          "Plot: #{array[:Plot]}\n" +
          "IMDB Rating: #{array[:imdbRating]}\n" +
          "IMDB Votes: #{array[:imdbVotes]}\n" +
          "Poster: #{array[:Poster].sub("._V1_SX300", "")}"
        end

        command(:todayandtomorrow) do |event, *args|
          event.channel.start_typing
          args = args.join(' ')

          if args.nil?
            "**TODAY AND TOMORROW CHANNEL**\n" +
            "Welcome to the Today and Tomorrow Channel. Use these commands:\n" +
            "`&todayandtomorrow details`: Shows you detailed fortunes."
          elsif args == "details"
            text_love = File.readlines("text/Other/Text/todayandtomorrowlove.txt").sample.chomp
            text_work = File.readlines("text/Other/Text/todayandtomorrowwork.txt").sample.chomp
            text_study = File.readlines("text/Other/Text/todayandtomorrowstudy.txt").sample.chomp
            text_communication = File.readlines("text/Other/Text/todayandtomorrowcommunication.txt").sample.chomp
            text_money = File.readlines("text/Other/Text/todayandtomorrowmoney.txt").sample.chomp

            prng = Random.new

                emoji_love = prng.rand(1..5)
                emoji_work = prng.rand(1..5)
                emoji_study = prng.rand(1..5)
                emoji_communication = prng.rand(1..5)
                emoji_money = prng.rand(1..5)

                emoji_diamond = "<:TodayAndTomorrowChannelDiamond:275403049437233153>"

                emoji_love = ("<:TodayAndTomorrowChannelLove:275402579780042764>" * emoji_love) + (emoji_diamond * 5 - emoji_love)
                emoji_work = ("<:TodayAndTomorrowChannelWork:275402433172209665>" * emoji_love) + (emoji_diamond * 5 - emoji_work)
                emoji_study = ("<:TodayAndTomorrowChannelStudy:275402471357153282>" * emoji_love) + (emoji_diamond * 5 - emoji_study)
                emoji_communication = ("<:TodayAndTomorrowChannelCommunica:275402659899375627>" * emoji_love) + (emoji_diamond * 5 - emoji_communication)
                emoji_money = ("<:TodayAndTomorrowChannelMoney:275402527384535042>" * emoji_love) + (emoji_diamond * 5 - emoji_money)

                "**DETAILS**\n" +
                "**Love**\n" +
                "#{emoji_love} - #{text_love}\n" +
                "**Work**\n" +
                "#{emoji_work} - #{text_work}\n" +
                "**Study**\n" +
                "#{emoji_study} - #{text_study}\n" +
                "**Communication**\n" +
                "#{emoji_communication} - #{text_communication}\n" +
                "**Money**\n" +
                "#{emoji_money} - #{text_money}"
              end
            end

        command(:choose, min_args: 1) do |event, *args|
          event.channel.start_typing
          args.sample
        end

        command(:coin) do |event, *args|
          event.channel.start_typing
            args = args.join(' ')

            if args.nil?
            amount = 1
            else
            begin
                amount = args.to_i
            rescue
                "Invalid input #{args}: not a number"
            end
          end

            if amount == 1
              coin_flip = %w(tails heads).sample
              "flips a coin and gets #{coin_flip}."
            elsif amount == 0
              'makes a coin flipping motion'
            else
              prng = Random.new
              heads = prng.rand(1..amount)
              tails = amount - heads
              "flips #{amount} coins and gets #{heads} heads and #{tails} tails."
        end
      end


        command(:poll, min_args: 2) do |event, type, *options|
          event.channel.start_typing
            # Grab text
            questions = options.join(' ')
            questionMatch = questions.scan(/"([^"]*)"/)
            if questionMatch.nil? || questionMatch[0].nil? || questionMatch[0] == ' '
                event.respond('❌ Enter valid questions! Hint: check your format.')
                break
            end
            unless type == 'ab' || type == 'yn'
                event.respond("❌ That's not a valid poll type!")
                break
            end
            if type == 'ab'
                if questionMatch[1].nil? || questionMatch[1] == '' || questionMatch[1] == ' '
                    event.respond('❌ Enter valid questions! Hint: check your format.')
                    break
                end
            end
            pollFormat = if type == 'yn'
                             (questionMatch[0][0]).to_s
                         elsif type == 'ab'
                             "#{questionMatch[0][0]} (🇦) or #{questionMatch[1][0]} (🇧)?"
            end
            # screw validation
            message = event.respond("🗳 **Poll:** #{pollFormat}")
            if type == 'yn'
                # If you can't see the following, they're a white checkmark and the letter X (but as a boxed in character).
                message.react '☑'
                message.react '🇽'
            elsif type == 'ab'
                # The following are the boxed in version of the letters A and B.
                message.react '🇦'
                message.react '🇧'
            end
        end
      end
    end
  end
