require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @product = products(:kajzerka)
    @recipe = recipes(:naBulke)
  end

  test "should get index" do
    get :index,product_id: @product.id #product_recipes_path(@product) #
    assert_response :success
  end

  test "should get new" do
    get :new,product_id: @product.id
    assert_response :success
  end

  test "should get create" do
    assert_difference('Recipe.count',1) do
      post :create,product_id: @product.id,id: @recipe.id, recipe: {amount: @recipe.amount, product_id: @recipe.product.id, ingredient_id:@recipe.ingredient.id }
    end
    assert_redirected_to product_recipes_path(@product)
  end

  test "should get destroy" do
    assert_difference('Recipe.count', -1) do
      delete :destroy,product_id: @product.id,id: @recipe
    end
    assert_redirected_to product_recipes_path(@product)
  end

  test "should get update" do
    put :update,product_id: @product.id,id: @recipe
    assert_response :success
  end

  test "should get show" do
    get :show,product_id: @product.id,id: @recipe #product_recipe_path(@product,@recipe)#:show,product_id: @product.id
    assert_response :success
  end

end
