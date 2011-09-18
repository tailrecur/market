require File.dirname(__FILE__) + '/../test_helper'
require 'retrieval/nse_reader'

class NseReaderTest < Test::Unit::TestCase
    fixtures :companies

#    def test_update_company_list
#        NseReader.update_companies_list
#    end

    def test_update_trading_data
        NseReader.update_trading_data
#        assert_equal true, Company.find(:first).quarterly_results.size > 0
    end
end
