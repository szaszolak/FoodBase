class CompareController < ApplicationController
  def index
    get_compared_products
    get_compared_products_metrics
  end

  	def show
	   get_compared_products
  	 @metric = Metric.find(params.require(:metric))
  
  		 respond_to do |format|
	      format.html{ }
	      format.json {  	
	      		get_chart_data
	      	 }
	    end
	end

  def get_chart

     get_compared_products
     @metric = Metric.find(params.require(:metric))
     get_chart_data
     pepare_charts current_user
     send_file @path+"#{@metric.id}.png", type: "image/gif", disposition: "inline"
  end

  private
    def get_compared_products
    	begin
    		  ids = JSON.parse(params.require(:competitors_ids))
     		 @competitors = Product.find(ids)
      		 @competitors.sort_by! {|x| x.metrics.count}.reverse!
    	rescue Exception => e
    		@competitors = []
    	end
    
    end

    def get_compared_products_metrics
      @metrics = []
      @competitors.each do |competitor|
      	@metrics+=competitor.metrics
      end

      @metrics = @metrics.uniq
    end

    def get_chart_data
    	@chart_data = []

	  	@competitors.each do |comp|
	  		comp.samples.joins(:sensory_analyses).where("sensory_analyses.metric_id=?", @metric.id).distinct.each do |sample|
				repetitions = sample.sensory_analyses.where(metric_id: @metric.id)
				avg = 0
				dev = 0
				if repetitions.size > 1
					avg = repetitions.map {|s| s.value}.sum()/repetitions.size
					dev = Math.sqrt( repetitions.map{|s| (s.value - avg)**2}.sum() * (1.0/(repetitions.size() -1)) )
					@chart_data<<{prod_id: sample.product.id,prod_name: sample.product.name,name: sample.additive.name + " "+sample.amount.to_s,value: avg,deviation: dev}
				elsif repetitions.size > 0
					avg = repetitions.map {|s| s.value}.sum()/repetitions.size
					@chart_data<<{prod_id: sample.product.id,prod_name: sample.product.name, name: sample.additive.name + " "+sample.amount.to_s,value: avg,deviation: dev}
				end
	  		end
	  	end
	  
	end

  def pepare_charts(current_user,size="460x512")
   
    subdirectory = Time.now.to_i.to_s 
      @path = "app/assets/images/"+current_user.id.to_s
   
      FileUtils.remove_dir @path, true
      @path+="/"+subdirectory+"/"
      charts = [] 
      files = []
      FileUtils.makedirs(@path)
        
      #@product.samples.calculate(:avg,:group)

      
        file = File.new(@path+"#{@metric.id}.png","w+")
        chart = Gruff::Bar.new(size)
        chart.y_axis_label = @metric.name
        
        chart.theme = {
           :colors => %w(green orange purple #cccccc), # colors can be described on hex values (#0f0f0f)
          :marker_color => 'grey', # The horizontal lines color
          :background_colors =>'white' 
        } 
         chart.title = @metric.name
          @chart_data.each do |data|
            chart.data(data[:prod_name]+" "+data[:name],data[:value])
          end

        vals =  @chart_data.map{|x|x[:value].to_f}
       chart.maximum_value = vals.max * 1.1
       chart.minimum_value = vals.min * 0.8
       chart.write(file.path)    
    end
end
