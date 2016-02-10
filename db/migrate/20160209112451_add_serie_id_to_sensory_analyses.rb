class AddSerieIdToSensoryAnalyses < ActiveRecord::Migration
   def up
   	add_column :sensory_analyses, :serie_id, :integer
  end

  def down
  	remove_column :sensory_analyses, :serie_id
  end
end
