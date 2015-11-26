class AddRepetitionsToProduct < ActiveRecord::Migration
  def change
  	add_column :products,:repetitions,:integer
  end
end
