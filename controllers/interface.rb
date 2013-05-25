module Interface

	CLEAR = "\e[H\e[2J"
	def home_screen(user)
		@user = user

		title = <<EOS


                  _______               __                     
                 |    ___|.---.-.-----.|  |_.---.-.-----.--.--.
                 |    ___||  _  |     ||   _|  _  |__ --|  |  |
                 |___|    |___._|__|__||____|___._|_____|___  |
                                                        |_____|
                     _______                    __         
                    |     __|.-----.-----.----.|  |_.-----.
                    |__     ||  _  |  _  |   _||   _|__ --|
                    |_______||   __|_____|__|  |____|_____|
                             |__|                          
           ______         __              __         __              
          |      |.---.-.|  |.----.--.--.|  |.---.-.|  |_.-----.----.
          |   ---||  _  ||  ||  __|  |  ||  ||  _  ||   _|  _  |   _|
          |______||___._||__||____|_____||__||___._||____|_____|__|  


EOS
		puts CLEAR
		puts title
		puts "Hello #{@user.user_id}!"
		puts "You have #{league_count}"
		puts "Please select an option"
		puts "Create new league ---> [n]"
		puts "View leagues---------> [v]"
		puts "Calculate score -----> [c]"
		puts "Exit-----------------> [x]"
		input = gets.chomp.downcase

		if input == "n"
			create_league
		elsif input == "v"
			view_leagues
		elsif input == "c"
			choose_position
		else
			puts `clear`		
		end
	end

	def create_league
		puts CLEAR
		puts "Please enter the name of the new league"
		league_name = gets.chomp
		league = League.create(name: league_name, user:@user.user_id)
		if league.save
			UserLeague.create(user_id: @user.id, league_id: League.last.id)
			rules
		else
			puts "There is already a league by that name"
			sleep (3)
			create_league
		end
	end

	def league_count
		num_leagues = @user.leagues.all.size
		if num_leagues == 0 || num_leagues >= 2
			return "#{num_leagues} leagues"
		else
			return "#{num_leagues} league"
		end
	end

	def view_leagues
		puts CLEAR
		unless @user.leagues.all.empty?
			@user.leagues.all.each {|item| puts "#{item.name}"}
		else
			puts "there are no saved leagues"
			no_leagues_navbar
		end
		puts "[c]alculate score, [v]iew league rules, [d]elete league, [b]ack to home"
		input = gets.chomp.downcase
		if input == "v"
			puts "enter name of league you would like to view"
			input2 = gets.chomp.downcase
			rules(@user.leagues.where(name: input2).first)
		end
		delete_league if input == "d"	
		home_screen(@user) if input == "b"	
		choose_position if input == "c"
	end

	def delete_league
		puts "enter name of league to delete"
		input2 = gets.chomp.downcase
		leagues = @user.leagues.where(name: input2).first
		leagues.destroy
		home_screen(@user)
	end

	def rules(league = League.last)
		puts CLEAR
		new_league = league
		rules =<<EOS
#{new_league.name.upcase}
Pass
Touchdown....................#{new_league.pass_td}
Every 25 Yards...............#{new_league.pass_yards}
Interception................#{new_league.int}
2 point conv pass............#{new_league.pass_2pt}

Rush
Touchdown....................#{new_league.rush_td}
Every 10 Yards...............#{new_league.rush_yards}
2 point conv rush............#{new_league.rush_2pt}

Receiving
Touchdown....................#{new_league.rec_td}
Every 10 Yards...............#{new_league.rec_yards}
2 point conv rec.............#{new_league.rec_2pt}
EOS
		puts rules
		puts "Would you like to change the scoring rules? [y/n]"
		input = gets.chomp.downcase

		if input == "y"
			rule_change(new_league)
		else
			home_screen(@user)
		end
	end

	def rule_change(league)
		puts CLEAR
		new_league = league
		rules =<<EOS
#{new_league.name.upcase}
Pass
Touchdown....................#{new_league.pass_td}
Every 25 Yards...............#{new_league.pass_yards}
Interception................#{new_league.int}
2 point conv pass............#{new_league.pass_2pt}

Rush
Touchdown.....................#{new_league.rush_td}
Every 10 Yards................#{new_league.rush_yards}
2 point conv rush.............#{new_league.rush_2pt}

Rec
Touchdown.....................#{new_league.rec_td}
Every 10 Yards................#{new_league.rec_yards}
2 point conv rec..............#{new_league.rec_2pt}
EOS
		puts rules
		puts "Please enter a category"
		input = gets.chomp.downcase
		pass_rules_change(new_league) if input == "pass"
		rush_rules_change(new_league) if input == "rush"
		rec_rules_change(new_league) if input == "rec"
	end

	def pass_rules_change(league)
		puts "Please select rule to change"
		puts "[1] Touchdown"
		puts "[2] Yards"
		puts "[3] Interception"
		puts "[4] 2 point conv"
		input = gets.chomp.to_i
		puts "Please enter new value"
		value = gets.chomp.to_i
		league.update_attributes(pass_td: value) if input == 1
		league.update_attributes(pass_yards: value) if input == 2
		league.update_attributes(int: value) if input == 3
		league.update_attributes(pass_2pt: value) if input == 4
		navbar(league)
	end

	def rush_rules_change(league)
		puts "Please select rule to change"
		puts "[1] Touchdown"
		puts "[2] Yards"
		puts "[3] 2 point conv"
		input = gets.chomp.to_i
		puts "Please enter new value"
		value = gets.chomp.to_i
		league.update_attributes(rush_td: value) if input == 1
		league.update_attributes(rush_yards: value) if input == 2
		league.update_attributes(rush_2pt: value) if input == 3
		navbar(league)
	end

	def rec_rules_change(league)
		puts "Please select rule to change"
		puts "[1] Touchdown"
		puts "[2] Yards"
		puts "[3] 2 point conv"
		input = gets.chomp.to_i
		puts "Please enter new value"
		value = gets.chomp.to_i
		league.update_attributes(rec_td: value) if input == 1
		league.update_attributes(rec_yards: value) if input == 2
		league.update_attributes(rec_2pt: value) if input == 3
		navbar(league)
	end

	def navbar(league)
		puts "[b]ack to edit, [h]ome screen"
		input = gets.chomp.downcase
		rule_change(league) if input == "b"
		home_screen(@user) if input == "h"
	end

	def no_leagues_navbar
		puts "[b]ack to home, [c]reate new league, E[x]it"
		input = gets.chomp.downcase
		home_screen(@user) if input == "b"
		create_league if input == "c"
		puts `clear` if input == "x"
	end

end