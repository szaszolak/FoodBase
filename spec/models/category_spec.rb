require 'rails_helper'

describe 'category' do

  it 'has a name' do
    expect(FactoryGirl.create(:category)).to be_valid
  end

  it 'has downcased name' do
  	expect(
  		FactoryGirl.create(:category,name: "Chleb").name
  		).to be_eql "chleb"
  end

  it 'has uniqe name' do
	first = FactoryGirl.create(:category)
	expect(FactoryGirl.build(:category,name: first.name)).to_not be_valid
  end

  it "can't be destroyed while having a reference to product" do
    category = FactoryGirl.create(:category)
    product = FactoryGirl.create(:product,category:category)
    expect(product.category).to be_eql category
  
    expect{category.destroy}.not_to change{Category.count}
  end

end