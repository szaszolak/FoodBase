
class Product < ActiveRecord::Base
	#acts_as_xlsx
	belongs_to :category
	before_save :externalize_url
	has_many :recipes, dependent: :destroy
	has_many :ingredients, through: :recipes
	has_many :samples, dependent: :destroy
	has_many :sensory_analyses, through: :samples
	has_many :metrics,through: :samples
	has_many :additives,through: :samples


	validates :description, :name,:category_id, presence: true 
	validates_associated :recipes

	private 
	def externalize_url
		unless /^http:\/\//.match(self.article_url)
			self.article_url = "http:\/\/"+self.article_url;
		end
	end
end
