class SensoryAnalysesController < ApplicationController
  before_action :set_sensory_analysis, only: [:show, :edit, :update, :destroy]

  # GET /sensory_analyses
  # GET /sensory_analyses.json
  def index
    @sensory_analyses = SensoryAnalysis.all
  end

  # GET /sensory_analyses/1
  # GET /sensory_analyses/1.json
  def show
  end

  # GET /sensory_analyses/new
  def new
    @sensory_analysis = SensoryAnalysis.new
  end

  # GET /sensory_analyses/1/edit
  def edit
  end

  # POST /sensory_analyses
  # POST /sensory_analyses.json
  def create
    @sensory_analysis = SensoryAnalysis.new(sensory_analysis_params)

    respond_to do |format|
      if @sensory_analysis.save
        format.html { redirect_to @sensory_analysis, notice: 'Sensory analysis was successfully created.' }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensory_analysis_params
      params.require(:sensory_analysis).permit(:color_L, :color_A, :color_B, :cutting_strength, :fat, :humidity)
    end
end
