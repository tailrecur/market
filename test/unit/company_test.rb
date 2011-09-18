require File.dirname(__FILE__) + '/../test_helper'

class CompanyTest < Test::Unit::TestCase
    fixtures :companies

    def test_load_quarterly_results
        url = "file://C:/workspace/market/test/mocks/nse/results_comparison.htm?symbol=<symbol>"
#        uri = URI.parse("http://www.nseindia.com/content/equities/EQUITY_L.csv")
        ashok = companies(:ashok_leyland)
        ashok.update_quarterly_results url
        assert_equal 5, ashok.financial_results.size
    end
end



