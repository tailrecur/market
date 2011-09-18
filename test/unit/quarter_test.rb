require File.dirname(__FILE__) + '/../test_helper'

class QuarterTest < Test::Unit::TestCase
    def test_current_quarter
        assert_equal Quarter::First, Quarter.get_quarter(Date.parse("31-Apr"))
        assert_equal Quarter::First, Quarter.get_quarter(Date.parse("30-Jun"))
        assert_equal Quarter::Second, Quarter.get_quarter(Date.parse("01-Jul"))
    end
end



