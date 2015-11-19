require 'test_helper'

class SensoryAnalysesControllerTest < ActionController::TestCase
  setup do
    @sensory_analysis = sensory_analyses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sensory_analyses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sensory_analysis" do
    assert_difference('SensoryAnalysis.count') do
      post :create, sensory_analysis: { color_A: @sensory_analysis.color_A, color_B: @sensory_analysis.color_B, color_L: @sensory_analysis.color_L, cutting_strength: @sensory_analysis.cutting_strength, fat: @sensory_analysis.fat, humidity: @sensory_analysis.humidity }
    end

    assert_redirected_to sensory_analysis_path(assigns(:sensory_analysis))
  end

  test "should show sensory_analysis" do
    get :show, id: @sensory_analysis
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sensory_analysis
    assert_response :success
  end

  test "should update sensory_analysis" do
    patch :update, id: @sensory_analysis, sensory_analysis: { color_A: @sensory_analysis.color_A, color_B: @sensory_analysis.color_B, color_L: @sensory_analysis.color_L, cutting_strength: @sensory_analysis.cutting_strength, fat: @sensory_analysis.fat, humidity: @sensory_analysis.humidity }
    assert_redirected_to sensory_analysis_path(assigns(:sensory_analysis))
  end

  test "should destroy sensory_analysis" do
    assert_difference('SensoryAnalysis.count', -1) do
      delete :destroy, id: @sensory_analysis
    end

    assert_redirected_to sensory_analyses_path
  end
end
