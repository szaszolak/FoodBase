class IngredientRemoveColumnAmount < ActiveRecord::Migration
  def up
  	remove_column :ingredients, :amount
  	remove_column :ingredients, :product_id
  end

  def down
    add_column :ingredients, :amount
    add_column :ingredients, :product_id
  end
end