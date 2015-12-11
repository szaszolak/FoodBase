
json.(@product, :id, :name)


json.metrics @product.metrics.distinct() do |metric|
	json.name metric.name
	json.samples @product.samples.joins(:sensory_analyses).where("sensory_analyses.metric_id=?", metric.id).distinct do |sample|
		json.name sample.additive.name + " "+sample.amount.to_s
		repetitions = sample.sensory_analyses.where(metric_id: metric)
		json.value repetitions.map {|s| s.value}.sum()/repetitions.count
	end
end