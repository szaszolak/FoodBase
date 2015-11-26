class RemoveAttribiutesColumnsFromSensoryAnalises < ActiveRecord::Migration
  def up
  	remove_column :sensory_analyses, :color_L
  	remove_column :sensory_analyses, :color_A
  	remove_column :sensory_analyses, :color_B
  	remove_column :sensory_analyses, :cutting_strength
  	remove_column :sensory_analyses, :fat
  	remove_column :sensory_analyses, :humidity

  end

  def down
  	add_column :sensory_analyses, :color_L, :decimal
  	add_column :sensory_analyses, :color_A, :decimal
  	add_column :sensory_analyses, :color_B, :decimal
  	add_column :sensory_analyses, :cutting_strength, :decimal
  	add_column :sensory_analyses, :fat, :decimal
  	add_column :sensory_analyses, :humidity, :decimal
  end
end
