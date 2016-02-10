class CreateExperimentDefinitions < ActiveRecord::Migration
  def change
    create_table :experiment_definitions do |t|
      t.references :product, index: true, foreign_key: true
      t.references :metric, index: true, foreign_key: true
      t.integer :series
      t.integer :repetitions

      t.timestamps null: false
    end
  end
end
