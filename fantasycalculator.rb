require 'league'
puts "Welcome to the Fantasy Football Calculator"
puts "please enter choice"
puts "create new league  [n]"
puts "calculate score    [c]"

input_intro = gets.chomp

if input_intro == "n"
  league = League.new
else
  #run program
end