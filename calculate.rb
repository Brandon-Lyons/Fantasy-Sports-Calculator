
module Calculate
	CLEAR = "\e[H\e[2J"
	#will collect player stats here and then calculate score for each
	#statistical category

	#call stat api here or csv
	# players = %x(python -c 'import nflgame; week = nflgame.games(2012, 1); players = nflgame.combine(week); player = players.name("F.Gore"); print player.formatted_stats()')
		# test = players.split(",")
		# puts test
		# input = "Tom Brady"
		# initial = input[0]
		# last = input[/(\w+)\s*$/, 1]
		# puts "#{initial}.#{last}"
	def choose_position
		puts CLEAR
		puts "Please enter the position of the player"
		position = gets.chomp.downcase
		list_players(position)
	end

	def list_players(position)
		csv = CSV.read("#{position}.csv")
		array = []
		i = 1
		until i == 26
			row = csv[i][0].split(" ").reverse.join(" ").delete(",")
			array << row
			i += 1
		end
		puts CLEAR
		array.each_with_index {|item, i| puts "#{i + 1}. #{item}"}
		puts "Enter the name of the player"
		name = gets.titleize.chomp
		puts "What year?"
		year = gets.chomp.to_i
		puts "What week"
		week = gets.chomp.to_i
		initial = name[0]
		last = name[/(\w+)\s*$/, 1]
		player = "#{initial}.#{last}"
		get_stats(year, week, player)
	end

	def get_stats(year, week, player)
		stat_line = %x(python -c 'import nflgame; week = nflgame.games(#{year}, #{week}); players = nflgame.combine(week); player = players.name("#{player}"); print player.formatted_stats()')
		puts stat_line.hash
	end

	def calculate_score
		
		

	end

end