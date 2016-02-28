class CompareController < ApplicationController
  def index
    get_compared_products
    get_compared_products_metrics
  end

  def show
  	get_compared_products
  	@metric = Metric.find(params.require(:metric))
  	@chart_data = []

  	@competitors.each do |comp|
  		comp.samples.joins(:sensory_analyses).where("sensory_analyses.metric_id=?", @metric.id).distinct.each do |sample|
			repetitions = sample.sensory_analyses.where(metric_id: @metric.id)
			avg = 0
			dev = 0
			if repetitions.size > 1
				avg = repetitions.map {|s| s.value}.sum()/repetitions.size
				dev = Math.sqrt( repetitions.map{|s| (s.value - avg)**2}.sum() * (1.0/(repetitions.size() -1)) )
			elsif repetitions.size > 0
				avg = repetitions.map {|s| s.value}.sum()/repetitions.size
			end
  			@chart_data<<{prod_id: sample.product.id,name: sample.additive.name + " "+sample.amount.to_s,value: avg,deviation: dev}
  		end
  	end
  	 respond_to do |format|
      format.html{ }
      format.json
    end
  end

  private
    def get_compared_products
      ids = JSON.parse(params.require(:competitors_ids))
      @competitors = Product.find(ids)
      @competitors.sort_by! {|x| x.metrics.count}.reverse!
    end

    def get_compared_products_metrics
      @metrics = []
      @competitors.each do |competitor|
      	@metrics+=competitor.metrics
      end

      @metrics = @metrics.uniq
    end
end
