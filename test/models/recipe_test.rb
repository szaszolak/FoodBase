require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
	test 'recipe should have asociacion with product' do
		recipe = recipes(:naBulke)
		recipe.product_id = nil
		assert_not recipe.valid?
	end

	test 'recipe should have asociacion with ingredient' do
		recipe = recipes(:naBulke)
		recipe.ingredient_id = nil
		assert_not recipe.valid?
	end
end
