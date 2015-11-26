class Metric < ActiveRecord::Base
	before_save do 
		self.name=self.name.downcase.strip
	end

	has_many :sensory_analyses
	has_many :samplse, through: :sensory_analyses
	validates :name, presence: :true


end
