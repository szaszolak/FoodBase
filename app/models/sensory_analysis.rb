class SensoryAnalysis < ActiveRecord::Base
	belongs_to :sample
	belongs_to :metric
	
	validates :sample_id, :metric_id , presence: true
end
