class AddSampleToSensoryAnalyses < ActiveRecord::Migration
  def change
    add_reference :sensory_analyses, :sample, index: true, foreign_key: true
  end
end
