require 'io/console'
module Login

	def intro
		puts CLEAR
		puts "Please login to access your leagues."
		puts "If you do not have an account please create one"
		puts "[L]ogin"
		puts "[C]reate account"
		puts "[D]elete account"
		puts "E[x]it"
		input = gets.chomp.upcase
		login if input == "L"
		create_account if input == "C"
		delete_account if input == "D"
		puts `clear` if input == "X"
	end

	def login
		puts CLEAR
		puts "please enter user name"
		user_name = gets.chomp
		puts "please enter password"
		password = STDIN.noecho(&:gets)
		if authentication(user_name, password.chomp)
			home_screen(User.where(user_id: user_name).first)
		else
			incorrect_login
		end	
	end

	def incorrect_login
		puts "User name and/or password is incorrect"
		puts "[r]etry, [c]reate account"
		input = gets.chomp.downcase
		login if input == "r"
		create_account if input == "c"
	end

	def delete_account
		users = User.all
		unless users.empty?
			users.each_with_index {|item, i| puts "#{i + 1}. #{item.user_id}"}
			puts "Select account to delete by number"
			input = gets.chomp.to_i
			puts "Enter account password to confirm deletion"
			puts "WARNING this will delete all leagues associated with this account"
			password = STDIN.noecho(&:gets).chomp
			if authentication(users[input - 1].user_id, password)
				destroy_account(users[input - 1].user_id)
			else
				puts "password doesn't match"
				sleep(3)
				intro
			end
		else
			puts "There are no accounts"
			puts "[C]reate account, E[x]it"
			input = gets.chomp.downcase
			create_account if input == "c"
		end
	end

	def create_account
		puts CLEAR
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
			true
		else
			false
		end
	end

	def destroy_account(user_name)
		user = User.where(user_id: user_name).first
		leagues = user.leagues.all
		user.destroy
		leagues.each do |item|
			item.destroy
		end
		intro
	end
end		