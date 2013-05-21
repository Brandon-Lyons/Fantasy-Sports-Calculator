module Interface

	CLEAR = "\e[H\e[2J"
	def home_screen(user_id)
		@user_id = user_id
		@leagues = League.where(:user_id => @user_id).all

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
		puts "Hello #{@user_id}!"
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
		league = League.create(user_id: @user_id, name: league_name)
		if league.save
			rules
		else
			puts "There is already a league by that name"
			sleep (3)
			create_league
		end
	end

	def view_leagues
		puts CLEAR
		leagues = @leagues 
		unless leagues.empty?
			leagues.each_with_index {|item, i| puts "#{i + 1}. #{item.name}"}
		else
			puts "there are no saved leagues"
		end
		puts "[c]alculate score, [v]iew league rules, [d]elete league, [b]ack to home"
		input = gets.chomp.downcase
		if input == "v"
			puts "enter name of league you would like to view"
			input2 = gets.chomp.downcase
			rules(League.where(user_id: @user_id, name: input2).first)
		end
		delete_league if input == "d"	
		home_screen(@user_id) if input == "b"	
		choose_position if input == "c"
	end

	def delete_league
		puts "enter name of league to delete"
			input2 = gets.chomp.downcase
			leagues = (League.where(user_id: @user_id, name: input2).all)
		leagues.each do |item|
			item.destroy
		end
		home_screen(@user_id)
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
			home_screen(@user_id)
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
		home_screen(@user_id) if input == "h"
	end

end