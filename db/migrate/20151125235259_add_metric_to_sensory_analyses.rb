class AddMetricToSensoryAnalyses < ActiveRecord::Migration
  def change
    add_reference :sensory_analyses, :metric, index: true, foreign_key: true
    add_column :sensory_analyses, :repetition_id, :integer
  end
end
