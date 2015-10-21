class Category < ActiveRecord::Base
	has_many :products

	validates :name, presence: true

	before_destroy :ensure_not_referenced_by_any_product

	private

	def ensure_not_referenced_by_any_product
		if products.empty?
			return true
		else
			errors.add(:base, 'Products present')
			return false
		end
	end 

end
