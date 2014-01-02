require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '.navi #ddtopmenubar a', minimum: 4
    assert_select '.row .entry', 3
    assert_select 'h3', 'Mr.President'
    assert_select '.item-price', /\$[,\d]+\.\d\d/
  end

end
