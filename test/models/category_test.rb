require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "category must have name" do
  	category = Category.new
  	assert_not category.valid?
  end

  test 'deleted category can not be referenced by any product' do
  	to_delete = categories(:referenced)
  	assert_not to_delete.destroy
  end
end
