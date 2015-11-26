json.array!(@metrics) do |metric|
  json.extract! metric, :id, :name
  json.url metric_url(metric, format: :json)
end
