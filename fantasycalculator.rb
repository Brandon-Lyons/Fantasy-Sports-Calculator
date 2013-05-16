require_relative 'bootstrap-ar'
# command = ARGV[0]

# if command == "add"
# 	league_name = ARGV[1]
# 	League.create(name: league_name)
# elsif command == "list"
# 	leagues = League.all
# 	leagues.each_with_index {|league, i| puts "#{i + 1}. #{league.name}"}
# elsif command == "delete"
# 	league = ARGV[1]
# 	deleted = League.where(name: league).all
# 	deleted.each do |item|
# 		item.destroy
# 	end
# end
CLEAR = "\e[H\e[2J"
def intro
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

	else
		puts `clear`		
	end
end

def create_league
	puts CLEAR
	puts "Please enter the name of the new league"
	league_name = gets.chomp
	League.create(name: league_name)
	rules
end

def view_leagues
	puts CLEAR
	leagues = League.all
	leagues.each_with_index {|item, i| puts "#{i + 1}. #{item.name}"}
	puts "[c]alculate score, [e]dit league rules, [d]elete league"
	input = gets.chomp.downcase
	if input == "e"
		puts "enter name of league to edit"
		input2 = gets.chomp.downcase
		rule_change(League.where(name: input2).first)
	elsif input == "d"
		puts "enter name of league to delete"
		input2 = gets.chomp.downcase
		delete_league(League.where(name: input2).all)
		view_leagues	
	end
end

def delete_league(leagues)
	leagues.each do |item|
		item.destroy
	end
end

def rules(league = League.last)
	puts CLEAR
	new_league = league
	rules =<<EOS
#{league.name}
"Touchdown....................#{new_league.touchdown}"
"Yards........................#{new_league.yards}"
"Turnover....................#{new_league.turnover}"
"2 point conversion...........#{new_league.twopoint}"
EOS
	puts rules
	puts "Would you like to change the scoring rules? [y/n]"
	input = gets.chomp.downcase

	if input == "y"
		rule_change(new_league)
	else
		intro
	end
end

def rule_change(league)
	puts CLEAR
	new_league = league
	rules =<<EOS
#{new_league.name}
"Touchdown....................#{new_league.touchdown}"
"Yards........................#{new_league.yards}"
"Turnover....................#{new_league.turnover}"
"2 point conversion...........#{new_league.twopoint}"
EOS
	puts rules
	puts "Please enter option and new value"
	puts "Touchdown [td]"
	puts "Yards [yd]"
	puts "Turnover [to]"
	puts "2 point conversion [pt]"
	input = gets.chomp.partition(/\b(\w+)\b/x) #will return array ["","first command","second command"]
	if input[1].downcase == "td"
		new_league.touchdown = input[2].to_i
		rules(new_league)
	end 

end
intro
