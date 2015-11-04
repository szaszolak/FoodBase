require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @ingredient =  ingredients(:maka)
      setup_user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    assert_difference('Ingredient.count') do
      post :create,  ingredient: { name: @ingredient.name }
    end
    assert_redirected_to ingredient_path(assigns(:ingredient))
  end

  test "should get destroy" do
    assert_difference('Ingredient.count',-1) do
      delete :destroy, id: ingredients(:two)
    end
     assert_redirected_to ingredients_path
  end


  test "should get update" do
    patch :update,id: @ingredient, ingredient: { name: @ingredient.name }
    assert_response :success
  end

  test "should get show" do
    get :show, :id => @ingredient
    assert_response :success
  end

end
