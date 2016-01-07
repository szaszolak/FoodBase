class ProductsController < ApplicationController
  
  before_action :set_product, only: [:show,:pepare_charts, :edit, :update, :destroy,:getPdf]
  #before_action :pepare_charts, only: [:show]
  #after_action :destroy_charts, only: [:show]
  # GET /products
  # GET /products.json
  def index
    apply_filters
    respond_to do |format|
      format.html
      format.js{}
    end
  end

  # GET /products/1
  # GET /products/1.json
  
  def show
    respond_to do |format|
      format.html{ pepare_charts}
      format.xls { response.headers['Content-Disposition'] = "attachment; filename=\"#{@product.name}.xls\""}
      format.xlsx
      format.json
      format.pdf{ pepare_charts('330x330')}
    end
  end

  #GET /products/compare
  def compare
    get_compared_products;
    get_max_recipies_count
  end
  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def newImport
  end


  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html{ redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

 

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :article_url, :category_id,:repetitions,:samples_count)
    end

    def get_compared_products
     # byebug
      ids = JSON.parse(params.require(:competitors_ids))
      @competitors = Product.find(ids)
    end

    def get_max_recipies_count
     @maxReciepiesCnt =  @competitors.collect {|comp| comp.recipes.count}.max
    end

    def apply_filters
      if params[:category_id].present?
        @products = Product.where(category_id:params.require(:category_id)).all
        if params.permit(:ingredient_id) and @products
          @products = @products.all {|product| product.ingredients.find(params.require(:ingredient_id))}
        end
      elsif params[:ingredient_id].present?
        @products = Product.joins(:recipes).where("recipes.ingredient_id = ?",params.require(:ingredient_id))
      else
        @products = Product.all
      end
    end

    def pepare_charts(size="460x512")
      @path = "app/assets/images/"+current_user.id.to_s+"/";
      FileUtils.remove_dir @path, true

      @charts = [] 
      files = []
      FileUtils.makedirs(@path)
        
      #@product.samples.calculate(:avg,:group)
      avgs = []
      @product.metrics.distinct().each do |metric|
        file = File.new(@path+"#{metric.id}.png","w+")
        line_chart = Gruff::Bar.new(size)
        line_chart.theme = {
           :colors => %w(green orange purple #cccccc), # colors can be described on hex values (#0f0f0f)
          :marker_color => 'grey', # The horizontal lines color
          :background_colors =>'white' 
        } 
         line_chart.title = metric.name
         avgs = @product.samples.joins(:sensory_analyses).where("sensory_analyses.metric_id=?", metric.id).group('samples.id').average(:value)
          avgs.each do |avg|
            
            s = @product.samples.find(avg[0])
            line_chart.data(s.additive.name + " "+s.amount.to_s,avg[1])
          end
       
       line_chart.maximum_value = avgs.map{|x|x[1]}.max * 1.1
       line_chart.minimum_value = avgs.map{|x|x[1]}.min* 0.8
      # p.samples.average(:value,:conditions=>['sensory_analyses.metric_id=?',1],:joins=>'INNER JOIN sensory_analyses on samples.id = sensory_analyses.sample_id',:group=>'id')
      #line_chart.labels = {0=>'Value (USD)'}
      line_chart.write(file.path)

      @charts.push current_user.id.to_s+"/"+metric.id.to_s+".png"
    end

    end

end

