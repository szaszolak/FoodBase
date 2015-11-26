class SensoryAnalysis < ActiveRecord::Base
	belongs_to :sample
	belongs_to :metric
end
