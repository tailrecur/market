require File.dirname(__FILE__) + '/../test_helper'
require 'mechanize'
require 'hpricot'
require 'retrieval/stockhive_reader'

class StockhiveReaderTest < Test::Unit::TestCase
    fixtures :companies

    def setup
        @reader = StockhiveReader.new(Company.find(:all))
#        @reader.login_url = "file:///C:/workspace/market/test/mocks/stockhive/login.htm/"
#        @reader.company_url = "http://localhost:3000/mocks/stockhive/financials.htm"
    end

    def test_update_financial_data
        @reader.update_financial_data
        assert_equal true, Company.find(:first).quarterly_results.size > 0
    end
end
