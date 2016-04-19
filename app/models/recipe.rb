class Recipe < ActiveRecord::Base
  belongs_to :product
  belongs_to :ingredient

  validates :product_id, :ingredient_id , presence: true
  validates_uniqueness_of :ingredient_id, :scope => :product_id
  validates_numericality_of :amount, greater_than: 0
end
