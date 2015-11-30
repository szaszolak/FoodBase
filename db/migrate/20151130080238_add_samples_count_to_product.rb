class AddSamplesCountToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :samples_count, :integer
  end
end
