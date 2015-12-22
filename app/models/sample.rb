class Sample < ActiveRecord::Base
  	belongs_to :product
	belongs_to :additive
	belongs_to :medium

	has_many :sensory_analyses, dependent: :destroy
	has_many :metrics, through: :sensory_analyses

	def get_average_metric(metric_id)
		get_repetitions(metric_id)
		repetitions.map {|s| s.value}.sum()/repetitions.size
	end

	def get_deviation(metric_id)
		get_repetitions(metric_id)
		repetitions.map{|s| (s.value - avg)**2}.sum() * (1/(repetitions.size() -1)) 
	end
	private
	def get_repetitions(metric_id)
		repetitions = self.sensory_analyses.where(metric_id: metric_id)
	end
end
