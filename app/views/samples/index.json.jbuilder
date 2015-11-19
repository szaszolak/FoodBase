json.array!(@samples) do |sample|
  json.extract! sample, :id, :amount, :temperature
  json.url sample_url(sample, format: :json)
end
