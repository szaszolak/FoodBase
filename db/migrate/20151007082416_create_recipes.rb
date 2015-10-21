class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.decimal :amount
      t.references :product, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
