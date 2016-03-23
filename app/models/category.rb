class Category < ActiveRecord::Base
	has_many :products

	validates :name, presence: true
	validates_uniqueness_of :name

	before_destroy :ensure_not_referenced_by_any_product
	
	before_create do
    	self.name = self.name.downcase
  	end

	private

	def ensure_not_referenced_by_any_product
		if products.empty?
			return true
		else
			errors.add(:base, 'Istnieją badania dotyczące tego produktu')
			return false
		end
	end 

end
