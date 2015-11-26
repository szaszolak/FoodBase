class AddValueToSensoryAnalyses < ActiveRecord::Migration
  def change
  	add_column :sensory_analyses, :value, :decimal
  end
end
