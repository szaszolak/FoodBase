class AddAdditiveToSamples < ActiveRecord::Migration
  def change
    add_reference :samples, :additive, index: true, foreign_key: true
  end
end
