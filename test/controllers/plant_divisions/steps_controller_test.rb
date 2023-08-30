require "test_helper"

class PlantDivisions::StepsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get plant_divisions_steps_show_url
    assert_response :success
  end

  test "should get update" do
    get plant_divisions_steps_update_url
    assert_response :success
  end
end
