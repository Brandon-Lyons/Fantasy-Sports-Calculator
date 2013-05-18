require 'test_help'

class FantasyCalculatorIntegrationTests < MiniTest::Unit::TestCase
	include DatabaseClean

# 	def test_adds_league
# 		assert_equal 0, League.count
# 		puts `ruby fantasycalculator.rb add test`
# 		assert_equal 1, League.count
# 	end

# 	def test_adds_multiple_leagues
# 		puts `ruby fantasycalculator.rb add test1`
# 		puts `ruby fantasycalculator.rb add test2`
# 		puts `ruby fantasycalculator.rb add test3`
# 		assert_equal 3, League.count
# 	end

# 	def test_list_leagues
# 		puts `ruby fantasycalculator.rb add test1`
# 		puts `ruby fantasycalculator.rb add test2`
# 		puts `ruby fantasycalculator.rb add test3`
# 		expected = <<EOS
# 1. test1
# 2. test2
# 3. test3
# EOS
# 		actual = `ruby fantasycalculator.rb list`
# 		assert_equal(expected, actual)
# 	end

# 	def test_delete_league
# 		puts `ruby fantasycalculator.rb add foo`
# 		puts `ruby fantasycalculator.rb add bar`
# 		puts `ruby fantasycalculator.rb add test`
# 		puts `ruby fantasycalculator.rb delete bar`
# 		expected = <<EOS
# 1. foo
# 2. test
# EOS
# 		actual = `ruby fantasycalculator.rb list`
# 		assert_equal(2, League.count)
# 		assert_equal(expected, actual)
# 	end

# 	def test_change_attribute_value
# 		league = League.new(name: "foo")
# 		league.touchdown = 5
# 		assert_equal(5, league.touchdown)
# 	end



end