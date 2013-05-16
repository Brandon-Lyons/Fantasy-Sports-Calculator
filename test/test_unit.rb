require 'test/unit'
require 'active_record'
require 'league'

class FantasyUnitTests < Test::Unit::TestCase

  def test_league_is_object
    league = League.new
    assert_equal(true, league.is_a?(Object))
  end

  def test_default_values
    league = League.new
    assert_equal(6, league.touchdown)
  end

  def test_default_values_yards
    league = League.new
    assert_equal(1, league.yards)
  end

  def test_change_default_values
    league = League.new(2)
    assert_equal(2, league.touchdown)
    assert_equal(1, league.yards)
  end

end