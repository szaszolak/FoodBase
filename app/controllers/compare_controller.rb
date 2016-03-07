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
    begin
         get_compared_products
         @metric = Metric.find(params.require(:metric))
         get_chart_data
         pepare_charts current_user
        send_file @path+"#{@metric.id}.png", type: "image/gif", disposition: "inline"
    rescue  Exception => e 
       flash[:danger] ="Nie udało się wygenerować wersji jpg wykresu."
        redirect_to  action: 'index', competitors_ids: params.require(:competitors_ids)
    end
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
  
   colors = %w(#006600  #006633 #006666 #006699 #0066CC #0066FF
#009900 #009933 #009966 #009999 #0099CC #0099FF
#00CC00 #00CC33 #00CC66 #00CC99 #00CCCC #00CCFF
#00FF00 #00FF33 #00FF66 #00FF99 #00FFCC #00FFFF
#330000 #330033 #330066 #330099 #3300CC #3300FF
#333300 #333333 #333366 #333399 #3333CC #3333FF
#336600 #336633 #336666 #336699 #3366CC #3366FF
#339900 #339933 #339966 #339999 #3399CC #3399FF
#33CC00 #33CC33 #33CC66 #33CC99 #33CCCC #33CCFF
#33FF00 #33FF33 #33FF66 #33FF99 #33FFCC #33FFFF
#660000 #660033 #660066 #660099 #6600CC #6600FF
#663300 #663333 #663366 #663399 #6633CC #6633FF
#666600 #666633 #666666 #666699 #6666CC #6666FF
#669900 #669933 #669966 #669999 #6699CC #6699FF
#66CC00 #66CC33 #66CC66 #66CC99 #66CCCC #66CCFF
#66FF00 #66FF33 #66FF66 #66FF99 #66FFCC #66FFFF
#990000 #990033 #990066 #990099 #9900CC #9900FF
#993300 #993333 #993366 #993399 #9933CC #9933FF
#996600 #996633 #996666 #996699 #9966CC #9966FF
#999900 #999933 #999966 #999999 #9999CC #9999FF
#99CC00 #99CC33 #99CC66 #99CC99 #99CCCC #99CCFF
#99FF00 #99FF33 #99FF66 #99FF99 #99FFCC #99FFFF
#CC0000 #CC0033 #CC0066 #CC0099 #CC00CC #CC00FF
#CC3300 #CC3333 #CC3366 #CC3399 #CC33CC #CC33FF
#CC6600 #CC6633 #CC6666 #CC6699 #CC66CC #CC66FF
#CC9900 #CC9933 #CC9966 #CC9999 #CC99CC #CC99FF
#CCCC00 #CCCC33 #CCCC66 #CCCC99 #CCCCCC #CCCCFF
#CCFF00 #CCFF33 #CCFF66 #CCFF99 #CCFFCC #CCFFFF
#FF0000 #FF0033 #FF0066 #FF0099 #FF00CC #FF00FF
#FF3300 #FF3333 #FF3366 #FF3399 #FF33CC #FF33FF
#FF6600 #FF6633 #FF6666 #FF6699 #FF66CC #FF66FF
#FF9900 #FF9933 #FF9966 #FF9999 #FF99CC #FF99FF
#FFCC00 #FFCC33 #FFCC66 #FFCC99 #FFCCCC #FFCCFF
#FFFF00 #FFFF33 #FFFF66 #FFFF99 #FFFFCC #FFFFFF)

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
        chart.sort = false 

        chart.theme = {
           :colors => %w(green orange purple #cccccc), # colors can be described on hex values (#0f0f0f)
          :marker_color => 'grey', # The horizontal lines color
          :background_colors =>'white' 
        }

        labels = {}
         chart.title = @metric.name
          @chart_data.each_with_index do |data,index|
           
            labels[index]= data[:prod_name]+" "+data[:name]
            chart.data(data[:prod_name]+" "+data[:name],data[:value],colors[data[:prod_id]])
          end
        
        vals =  @chart_data.map{|x|x[:value].to_f}
       chart.maximum_value = vals.max * 1.1
       chart.minimum_value = vals.min * 0.8

       chart.write(file.path)    
    end
end
