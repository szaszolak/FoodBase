class Additive < ActiveRecord::Base
	has_many :samples
	has_many :products, through: :samples

	validates :name, presence: true
	validates_uniqueness_of :name
	before_destroy :ensure_not_referenced_by_any_sample

	private

	def ensure_not_referenced_by_any_sample
		if samples.empty?
			return true
		else
			errors.add(:base, 'Dodatek jest używany w instniejących badaniach')
			return false
		end
	end 

end
