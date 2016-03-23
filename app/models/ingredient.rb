class Ingredient < ActiveRecord::Base
  has_many :recipes
  
  validates_uniqueness_of :name
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
  		errors.add(:base,'Istnieją receptury zawierające ten składnik.')
  		return false
  	end
  end

end
