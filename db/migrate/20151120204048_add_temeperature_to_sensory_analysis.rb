class AddTemeperatureToSensoryAnalysis < ActiveRecord::Migration
  def change
  	 add_column :sensory_analyses, :temperature, :decimal
  end
end
