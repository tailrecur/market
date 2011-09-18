require File.dirname(__FILE__) + '/../test_helper'
require 'sector_controller'

# Re-raise errors caught by the controller.
class SectorController; def rescue_action(e) raise e end; end

class SectorControllerTest < Test::Unit::TestCase
  def setup
    @controller = SectorController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
