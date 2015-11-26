class Metric < ActiveRecord::Base
	before_save do 
		self.name=self.name.downcase
	end

	has_many :sensory_analyses
	validates :name, presence: :true


end
