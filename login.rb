require 'io/console'
module Login

	def intro
		puts "\e[H\e[2J"
		puts "Please login to access your leagues."
		puts "If you do not have an account please create one"
		puts "[L]ogin"
		puts "[C]reate account"
		input = gets.chomp.upcase
		login if input == "L"
		create_account if input == "C"
	end

	def login
		puts "\e[H\e[2J"
		puts "please enter user name"
		user_name = gets.chomp
		puts "please enter password"
		password = STDIN.noecho(&:gets)
		authentication(user_name, password.chomp)			
	end

	def create_account
		puts "\e[H\e[2J"
		puts "please enter a user name"
		user_name = gets.chomp
		puts "please enter a password"
		password = gets.chomp
		account = User.create(user_id: user_name, password: password)
		unless account.save
			puts "There is already an account with that name"
			sleep (3)
			create_account
		else
			home_screen(User.where(user_id: user_name).first)
		end
	end

	def authentication(user_name, password)
		# puts account
		if User.exists?(:user_id=> user_name, :password=> password)
			home_screen(User.where(user_id: user_name).first.user_id)
		else
			puts "User name and/or password is incorrect"
			puts "[r]etry, [c]reate account"
			input = gets.chomp.downcase
			login if input == "r"
			create_account if input == "c"
		end
	end
end

		

