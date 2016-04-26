# spec/factories/experiment_definition.rb
FactoryGirl.define do
  factory :experiment_definition do |f|
  	product
  	metric
	f.series 2	
	f.repetitions 3
  end
end