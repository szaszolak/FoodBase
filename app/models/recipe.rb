class Recipe < ActiveRecord::Base
  belongs_to :product
  belongs_to :ingredient

  validates :product_id, :ingredient_id , presence: true
  validates_uniqueness_of :ingredient_id, :scope => :product_id
end
