class Ingredient < ActiveRecord::Base
  has_many :recipes
  validates :name, presence: true
    
  before_create do
    self.name = self.name.downcase
  end

  before_destroy :ensure_no_recipe_is_associated
  private

  def ensure_no_recipe_is_associated
  	unless recipes.any?
  	 	return true
  	else
  		errors.add(:base,'Recipes are using this ingredient')
  		return false
  	end
  end

end
