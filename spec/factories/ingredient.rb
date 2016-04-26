require 'faker'
# spec/factories/ingredient.rb
FactoryGirl.define do
  factory :ingredient do |f|
	f.name Faker::Lorem.word	
  end
end