require 'rails_helper'

describe 'ingredient' do
  let(:ingredient){FactoryGirl.create(:ingredient)}
  it 'has name' do
  	expect(FactoryGirl.build(:ingredient,name: nil)).to_not be_valid
  end

  it 'has uniqe name' do
  	expect(FactoryGirl.build(:ingredient,name: ingredient.name)).to_not be_valid
  end

  it 'has downcased name' do
  	expect(FactoryGirl.create(:ingredient, name: "TEST").name).to be_eql "test"
  end

  it "can't be deleted if associated to some recipe" do
  	FactoryGirl.create(:recipe,ingredient: ingredient)
  	expect{ingredient.destroy}.to_not change{Ingredient.count}
  end

end

