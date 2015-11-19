json.array!(@additives) do |additive|
  json.extract! additive, :id, :name
  json.url additive_url(additive, format: :json)
end
