class RemoveTemperatureFromSensoryAnalyses < ActiveRecord::Migration
  def change
  	remove_column :sensory_analyses, :temperature
  end
end
