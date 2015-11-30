class Metric < ActiveRecord::Base
	before_save do 
		self.name=self.name.downcase.strip
	end

	before_destroy :ensure_not_referenced_by_any_analysis

	has_many :sensory_analyses
	has_many :samplse, through: :sensory_analyses
	validates :name, presence: :true

	def ensure_not_referenced_by_any_analysis
		if sensory_analyses.empty?
			return true
		else
			errors.add(:base, 'Products present')
			return false
		end
	end 
end
