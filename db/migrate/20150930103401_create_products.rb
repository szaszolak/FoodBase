class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :description
      t.string :article_url

      t.timestamps null: false
    end
  end
end
