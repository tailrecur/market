require File.dirname(__FILE__) + '/../test_helper'
require 'formula_controller'

# Re-raise errors caught by the controller.
class FormulaController; def rescue_action(e) raise e end; end

class FormulaControllerTest < Test::Unit::TestCase
  def setup
    @controller = FormulaController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
