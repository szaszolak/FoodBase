class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.decimal :amount
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
