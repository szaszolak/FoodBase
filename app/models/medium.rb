class Medium < ActiveRecord::Base
	has_many :samples
	has_many :products, through: :samples
end
