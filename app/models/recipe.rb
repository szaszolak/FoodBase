class Recipe < ActiveRecord::Base
  belongs_to :product
  belongs_to :ingredient

  validates :product_id, :ingredient_id , presence: true
end
