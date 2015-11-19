class CreateSensoryAnalyses < ActiveRecord::Migration
  def change
    create_table :sensory_analyses do |t|
      t.decimal :color_L
      t.decimal :color_A
      t.decimal :color_B
      t.decimal :cutting_strength
      t.decimal :fat
      t.decimal :humidity

      t.timestamps null: false
    end
  end
end
