json.array!(@products) do |product|
  json.extract! product, :id, :description, :article_url
  json.url product_url(product, format: :json)
end
