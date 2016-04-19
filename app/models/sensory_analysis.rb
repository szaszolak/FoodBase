class SensoryAnalysis < ActiveRecord::Base
	belongs_to :sample
	belongs_to :metric
	
	validates :sample_id, :metric_id , presence: true
	validates_numericality_of :value, greater_than_or_equal_to: 0
end
