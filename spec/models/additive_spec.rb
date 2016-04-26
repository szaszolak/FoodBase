require 'rails_helper'

describe 'additive' do
  
  it 'has name' do
  	expect(FactoryGirl.build(:additive,name:nil)).to_not be_valid
  end
  
  let(:valid){FactoryGirl.create(:additive)}
  
  it 'has uniq name' do
    expect(FactoryGirl.build(:additive,name: valid.name)).to_not be_valid
  end

  it "can't be deleted while referenced by sample" do
  	FactoryGirl.create(:sample,additive: valid)
  	expect{valid.destroy}.to_not change{Additive.count}
  end

end