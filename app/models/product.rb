
class Product < ActiveRecord::Base
	#acts_as_xlsx
	belongs_to :category
	before_save :externalize_url
	has_many :recipes, dependent: :destroy
	has_many :ingredients, through: :recipes
	has_many :samples, dependent: :destroy
	has_many :sensory_analyses, through: :samples
	has_many :metrics,through: :samples
	has_many :additives,through: :samples
  has_many :experiment_definitions

	validates :description, :name,:category_id, presence: true 
	validates_associated :recipes
	 def pepare_charts(current_user,size="460x512")
      @path = "app/assets/images/"+current_user.id.to_s+"/";
      FileUtils.remove_dir @path, true

      charts = [] 
      files = []
      FileUtils.makedirs(@path)
        
      #@product.samples.calculate(:avg,:group)
      avgs = []
      self.metrics.distinct().each do |metric|
        file = File.new(@path+"#{metric.id}.png","w+")
        chart = Gruff::Bar.new(size)
        chart.y_axis_label = metric.name
        
        chart.theme = {
           :colors => %w(green orange purple #cccccc), # colors can be described on hex values (#0f0f0f)
          :marker_color => 'grey', # The horizontal lines color
          :background_colors =>'white' 
        } 
         chart.title = metric.name
         avgs = self.samples_with_metric(metric.id).group('samples.id').average(:value)
         avgs.each do |avg|
            
            s = self.samples.find(avg[0])
            chart.data(s.additive.name + " "+s.amount.to_s,avg[1])
          end
       
       chart.maximum_value = avgs.map{|x|x[1]}.max * 1.1
       chart.minimum_value = avgs.map{|x|x[1]}.min* 0.8
      # p.samples.average(:value,:conditions=>['sensory_analyses.metric_id=?',1],:joins=>'INNER JOIN sensory_analyses on samples.id = sensory_analyses.sample_id',:group=>'id')
      #line_chart.labels = {0=>'Value (USD)'}
      chart.write(file.path)

      charts.push current_user.id.to_s+"/"+metric.id.to_s+".png"
      end
      return charts
    end

    def samples_with_metric(metric_id)
      self.samples.joins(:sensory_analyses).where("sensory_analyses.metric_id=?",metric_id)
    end

	private 
	def externalize_url
		unless /^http:\/\//.match(self.article_url)
			self.article_url = "http:\/\/"+self.article_url;
		end
	end


end
