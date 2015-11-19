require 'test_helper'

class AdditivesControllerTest < ActionController::TestCase
  setup do
    @additive = additives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:additives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create additive" do
    assert_difference('Additive.count') do
      post :create, additive: { name: @additive.name }
    end

    assert_redirected_to additive_path(assigns(:additive))
  end

  test "should show additive" do
    get :show, id: @additive
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @additive
    assert_response :success
  end

  test "should update additive" do
    patch :update, id: @additive, additive: { name: @additive.name }
    assert_redirected_to additive_path(assigns(:additive))
  end

  test "should destroy additive" do
    assert_difference('Additive.count', -1) do
      delete :destroy, id: @additive
    end

    assert_redirected_to additives_path
  end
end
