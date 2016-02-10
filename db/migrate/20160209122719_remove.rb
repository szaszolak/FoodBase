class Remove < ActiveRecord::Migration
  def change
  	remove_column :products, :samples_count
  	remove_column :products, :repetitions
  end
end
