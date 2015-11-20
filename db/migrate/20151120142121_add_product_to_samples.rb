class AddProductToSamples < ActiveRecord::Migration
  def change
    add_reference :samples, :product, index: true, foreign_key: true
  end
end
