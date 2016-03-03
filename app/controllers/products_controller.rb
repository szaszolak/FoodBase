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
      format.html{ }
      format.xls { response.headers['Content-Disposition'] = "attachment; filename=\"#{@product.name}.xls\""}
      format.xlsx
      format.json
      format.pdf{ @charts = @product.pepare_charts(current_user,'720x576')}
    end
  end


  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end




  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html{ redirect_to product_recipes_path(@product), success: 'Product was successfully created.' }
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
        format.html { redirect_to @product, success: 'Product was successfully updated.' }
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
      format.html { redirect_to products_url, success: 'Product was successfully destroyed.' }
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

   

end

