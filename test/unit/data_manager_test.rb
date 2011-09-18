require File.dirname(__FILE__) + '/../test_helper'

class DataManagerTest < Test::Unit::TestCase
    fixtures :companies

#    def test_update_companies_list
#        uri = URI.parse("http://www.stockhive.com/company/find_by_name?company[companyname]=Bharti%20Airtel%20Ltd.")
##        uri = URI.parse("http://www.nseindia.com/content/equities/EQUITY_L.csv")
#        DataManager.update_companies_list uri
#        assert_not_nil Company.find(:all)
#    end
##
#    def test_update_quarterly_results
#        url = "file://C:/workspace/market/test/mocks/nse/results_comparison.htm?symbol=<symbol>"
##        url = "http://www.nseindia.com/marketinfo/companyinfo/eod/resHistory.jsp?symbol=<symbol>"
#        #        ashok = companies(:ashok_leyland)
#        DataManager.update_quarterly_results url
##        assert_equal 5, ashok.financial_results.size
#    end

    def test_test
         DataManager.test
    end
end



