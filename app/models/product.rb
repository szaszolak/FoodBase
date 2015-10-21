class Product < ActiveRecord::Base
	belongs_to :category
	has_many :recipes, dependent: :destroy
	has_many :ingredients, through: :recipes

	validates :description, :name, presence: true 
	validates_associated :recipes
end
