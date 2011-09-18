require File.dirname(__FILE__) + '/../test_helper'
require 'calculation/calculator'

class CalculatorTest < Test::Unit::TestCase
    fixtures :companies, :formulas

#    def test_update_company_list
#        NseReader.update_companies_list
#    end

    def test_extrapolate_score
        Calculator.extrapolate_score(companies(:ashok_leyland))
#        assert_equal true, Company.find(:first).quarterly_results.size > 0
    end
end
