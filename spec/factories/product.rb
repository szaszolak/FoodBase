require 'faker'
# spec/factories/product.rb
FactoryGirl.define do
  factory :product do |f|
    f.description Faker::Lorem.sentence
    f.article_url Faker::Internet.url
    f.name Faker::Lorem.word
    category
  end
end
