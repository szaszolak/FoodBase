require 'rails_helper'
require 'faker'

describe 'product' do


  it 'has name' do
  	expect(FactoryGirl.build(:product,name: nil)).to_not be_valid
  end

  it 'has category' do
  	expect(FactoryGirl.build(:product,category: nil)).to_not be_valid
  end

  it 'has description' do
    expect(FactoryGirl.build(:product,description: nil)).to_not be_valid
  end

  it 'has externalized url'do
    p = FactoryGirl.build(:product,article_url: 'www.wp.pl')
    p.save
    expect(p.article_url).to be_eql "http://www.wp.pl"
  end

  describe 'advanced features' do
    
    before(:each) do
      @prod = FactoryGirl.create(:product)
    end

    it 'returns samples with metric' do
      metric = FactoryGirl.create(:metric)
      3.times do
        a = FactoryGirl.create(:additive,name: Faker::Lorem.words)
        s = FactoryGirl.create(:sample,product: @prod,additive: a)
        3.times do |i|
          FactoryGirl.create(:sensory_analysis,sample:s,metric: metric)
        end 
      end
      samples = @prod.samples.joins(:sensory_analyses).where("sensory_analyses.metric_id=?",metric).to_a
      expect(samples).to be_eql @prod.samples_with_metric(metric).to_a
    end
    
  end

end