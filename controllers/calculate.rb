module Calculate

	def choose_position
		unless @user.leagues.all.empty?
			puts CLEAR
			puts "Please enter the position of the player"
			@position = gets.chomp.downcase
			get_list(@position)
		else
			puts "There are no leagues to calculate with!"
			puts "Please create a league"
			sleep(3)
			home_screen(@user)
		end
	end

	def get_list(position)
		csv = CSV.read("csv/#{position}.csv")
		@player_list = []
		i = 0
		until i == csv.length
			row = csv[i][0].split(" ").reverse.join(" ").delete(",")
			@player_list << row
			i += 1
		end
		list_players
	end

	def list_players
		puts CLEAR
		unless @player_list.empty?
			array = @player_list.shift(25)
			array.each_with_index {|item, i| puts "#{i + 1}. #{item}"}
			puts "Enter the name of the player or [>] to see next 25 players"
			name = gets.titleize.chomp
			list_players if name == ">"
			puts "What year?"
			year = gets.chomp.to_i
			puts "What week"
			week = gets.chomp.to_i
			initial = name[0]
			last = name[/(\w+)\s*$/, 1]
			player = "#{initial}.#{last}"
			get_stats(year, week, player)
		else
			get_list(@position)
		end
	end

	def get_stats(year, week, player)
		stat_line = %x(python -c 'import nflgame; week = nflgame.games(#{year}, #{week}); players = nflgame.combine(week); player = players.name("#{player}"); print player.formatted_stats()')
		stats = stat_line.split(",").flatten.join.split(":").join.split(" ")
		stats_hash = Hash[*stats.flatten]
		calculate_total_score(stats_hash, @user.leagues.all)
	end

	def calculate_pass_score(hash, league)
		td = hash["passing_tds"].to_i
		yards = hash["passing_yds"].to_i
		int = hash["passing_ints"].to_i
		two_pt = hash["passing_twoptm"].to_i
		td_rule = league.pass_td
		yard_rule = league.pass_yards
		int_rule = league.int
		two_pt_rule = league.pass_2pt
		td_score = td * td_rule
		yards_score = (yards / 25) * yard_rule
		int_score = int * int_rule
		two_pt_score = two_pt * two_pt_rule
		total = td_score + yards_score + two_pt_score + int_score
		total
	end

	def calculate_rush_score(hash, league)
		td = hash["rushing_tds"].to_i
		yards = hash["rushing_yds"].to_i
		two_pt = hash["rushing_twoptm"].to_i
		td_rule = league.rush_td
		yard_rule = league.rush_yards
		two_pt_rule = league.rush_2pt
		td_score = td * td_rule
		yards_score = (yards / 10) * yard_rule
		two_pt_score = two_pt * two_pt_rule
		total = td_score + yards_score + two_pt_score
		total
	end

	def calculate_rec_score(hash, league)
		td = hash["receiving_tds"].to_i
		yards = hash["receiving_yds"].to_i
		two_pt = hash["receiving_twoptm"].to_i
		td_rule = league.rec_td
		yard_rule = league.rec_yards
		two_pt_rule = league.rec_2pt
		td_score = td * td_rule
		yards_score = (yards / 10) * yard_rule
		two_pt_score = two_pt * two_pt_rule
		total = td_score + yards_score + two_pt_score
		total
	end

	def calculate_total_score(hash, leagues)
		leagues.each do |league|
	        pass = calculate_pass_score(hash, league)
	        rush = calculate_rush_score(hash, league)
	        rec = calculate_rec_score(hash, league)
	        total = pass + rush + rec
	        puts "#{league.name} total is #{total}"
	    end
	    puts "[c]alculate another player, [b]ack to home, E[x]it"
	    input = gets.chomp.downcase
	    choose_position if input == "c"
	    home_screen(@user) if input == "b"
	    puts `clear` if input == "x"
	end

end