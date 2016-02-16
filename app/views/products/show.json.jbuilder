
json.(@product, :id, :name)


json.metrics @product.metrics.distinct() do |metric|
	json.name metric.name
	json.samples @product.samples.joins(:sensory_analyses).where("sensory_analyses.metric_id=?", metric.id).distinct do |sample|
		json.name sample.additive.name + " "+sample.amount.to_s
		repetitions = sample.sensory_analyses.where(metric_id: metric)
		avg = 0
		dev = 0
		if repetitions.size > 1
			avg = repetitions.map {|s| s.value}.sum()/repetitions.size
			dev = Math.sqrt( repetitions.map{|s| (s.value - avg)**2}.sum() * (1.0/(repetitions.size() -1)) )
		elsif repetitions.size > 0
			avg = repetitions.map {|s| s.value}.sum()/repetitions.size
		end


		json.value avg
		json.deviation dev
	end
end