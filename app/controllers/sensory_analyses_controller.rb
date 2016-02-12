class SensoryAnalysesController < ApplicationController
  before_action :set_sensory_analysis, only: [:show, :edit, :update, :destroy]
  before_action :set_sample
  before_action :set_product
  # GET /sensory_analyses
  # GET /sensory_analyses.json
  def index
    if params[:metric_id]
      @sensory_analyses = @sample.sensory_analyses.where("metric_id=?",params[:metric_id])
      @definition = @product.experiment_definitions.where("metric_id=?",params[:metric_id]).first

    else
       @sensory_analyses = @sample.sensory_analyses
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /sensory_analyses/1
  # GET /sensory_analyses/1.json
  def show
  end

  # GET /sensory_analyses/new
  def new
    
    @sensory_analysis = @sample.sensory_analyses.build
    @sensory_analysis.repetition_id = params[:repetition]
    @sensory_analysis.serie_id = params[:series]
    @sensory_analysis.metric_id = params[:metric_id]
  end

  # GET /sensory_analyses/1/edit
  def edit
  end

  # POST /sensory_analyses
  # POST /sensory_analyses.json
  def create
    @sensory_analysis = @sample.sensory_analyses.build(sensory_analysis_params)

    respond_to do |format|
      if @sensory_analysis.save
        format.html { redirect_to product_sample_sensory_analyses_path(@product,@sample), notice: 'Sensory analysis was successfully created.' }
        format.json { render :show, status: :created, location: @sensory_analysis }
      else
        format.html { render :new }
        format.json { render json: @sensory_analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensory_analyses/1
  # PATCH/PUT /sensory_analyses/1.json
  def update
    respond_to do |format|
      if @sensory_analysis.update(sensory_analysis_params)
        format.html { redirect_to @sensory_analysis, notice: 'Sensory analysis was successfully updated.' }
        format.json { render :show, status: :ok, location: @sensory_analysis }
      else
        format.html { render :edit }
        format.json { render json: @sensory_analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensory_analyses/1
  # DELETE /sensory_analyses/1.json
  def destroy
    @sensory_analysis.destroy
    respond_to do |format|
      format.html { redirect_to sensory_analyses_url, notice: 'Sensory analysis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensory_analysis
      @sensory_analysis = SensoryAnalysis.find(params[:id])
    end
    def set_sample
      @sample = Sample.find(params[:sample_id])
    end
    def set_product
      @product = Product.find(params[:product_id])      
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def sensory_analysis_params
      params.require(:sensory_analysis).permit(:metric_id,:value,:repetition_id,:serie_id)
    end
end
