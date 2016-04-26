# spec/factories/recipe.rb
FactoryGirl.define do
  factory :recipe do |f|
  	product
  	ingredient
	f.amount '2'	
  end
end