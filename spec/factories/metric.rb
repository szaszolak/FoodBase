# spec/factories/metric.rb
FactoryGirl.define do
  factory :metric do |f|
	  f.name Faker::Lorem.word
  end
end