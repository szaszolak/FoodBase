class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.decimal :amount
      t.decimal :temperature

      t.timestamps null: false
    end
  end
end
