require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  
  test 'name should be present' do
  	ing = get_new_ingredient
  	ing.name = nil
  	assert_not ing.valid?
  end

  test 'name should be downcased before save'  do
  	ing = get_new_ingredient
  	ing.name = "TeSt"
  	ing.save
  	assert_equal ing.name, 'test' 
  end

  test "Ingredient refferd by recipe shouldn't be destroyed" do
    ing = ingredients(:maka)
    assert !ing.destroy
    assert_equal ing.errors[:base].join(';'), 'Recipes are using this ingredient'
  end
  
  def get_new_ingredient
  	ing = Ingredient.new
  	ing.name = "test"
  	ing
  end

end
