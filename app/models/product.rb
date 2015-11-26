
class Product < ActiveRecord::Base
	#acts_as_xlsx
	belongs_to :category
	has_many :recipes, dependent: :destroy
	has_many :ingredients, through: :recipes
	has_many :samples, dependent: :destroy
	has_many :sensory_analyses, through: :samples
	has_many :metrics,through: :samples
	has_many :additives,through: :samples


	validates :description, :name,:category_id, presence: true 
	validates_associated :recipes
end
