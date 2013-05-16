require 'active_record'
class League < ActiveRecord::Base
  attr_accessor :touchdown, :yards, :turnover, :twopoint

  def initialize(td=6, yd=1, int=-2, twopt=2)
    @touchdown = td
    @yards = yd
    @turnover = int
    @twopoint = twopt
  end

end