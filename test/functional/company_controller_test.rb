require File.dirname(__FILE__) + '/../test_helper'
require 'company_controller'

# Re-raise errors caught by the controller.
class CompanyController;
    def rescue_action(e)
        raise e
    end;
end

class CompanyControllerTest < Test::Unit::TestCase
    def setup
        @controller = CompanyController.new
        @request    = ActionController::TestRequest.new
        @response   = ActionController::TestResponse.new
    end
#
#    def test_update_company_list
#        post :update_companies
#        assert_response :redirect
#        assert_redirected_to :action => 'index'
#        assert_not_nil Company.find(:all)
#    end
#
#    def test_get_on_update_throws_error
#        get :update_companies
#        assert_response 405
#        assert_equal '405 HTTP POST required', @response.body
#    end

    def test_update_data
        get :update_quarterly_results

    end
end
