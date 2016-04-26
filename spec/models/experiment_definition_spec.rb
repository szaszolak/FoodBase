require 'rails_helper'

describe 'experiment definition' do
 
 it 'has integer type series' do
 	expect(FactoryGirl.build(:experiment_definition,series: 0.0)).to_not be_valid
 end

 it 'has integer positive count if series' do
 	invalid = FactoryGirl.build(:experiment_definition,series: -1)
 	expect(invalid).to_not be_valid
 	invalid.series = 0
 	expect(invalid).to_not be_valid
 end

 it 'has integer type repetitions' do
 	expect(FactoryGirl.build(:experiment_definition,repetitions: 0.0)).to_not be_valid
 end

 it 'has integer positive count if repetitions' do
 	invalid = FactoryGirl.build(:experiment_definition,repetitions: -1)
 	expect(invalid).to_not be_valid
 	invalid.repetitions = 0
 	expect(invalid).to_not be_valid
 end
 
 it 'belongs to some product' do
 	expect(FactoryGirl.build(:experiment_definition,product: nil)).to_not be_valid
 end
 
 it 'defines some metric' do
 	expect(FactoryGirl.build(:experiment_definition,metric: nil)).to_not be_valid
 end
 
 let(:product){FactoryGirl.create(:product)}
 let(:metric){FactoryGirl.create(:metric)}
 
 it 'defines uniqe metric for single product' do
   	FactoryGirl.create(:experiment_definition,product: product,metric: metric)
   	expect(FactoryGirl.build(:experiment_definition,product: product,metric: metric)).to_not be_valid
 end
end