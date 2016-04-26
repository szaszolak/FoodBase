# spec/factories/sensory_analysis.rb
FactoryGirl.define do
  factory :sensory_analysis do |f|
	  f.value 55.1
	  f.serie_id 1
	  f.repetition_id 1
	  sample
	  metric	
  end
end