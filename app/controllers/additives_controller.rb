class AdditivesController < ApplicationController
  before_action :set_additive, only: [:show, :edit, :update, :destroy]

  # GET /additives
  # GET /additives.json
  def index
    @additives = Additive.all
  end

  # GET /additives/1
  # GET /additives/1.json
  def show
  end

  # GET /additives/new
  def new
    @additive = Additive.new
  end

  # GET /additives/1/edit
  def edit
  end

  # POST /additives
  # POST /additives.json
  def create
    @additive = Additive.new(additive_params)

    respond_to do |format|
      if @additive.save
        format.html { redirect_to @additive, notice: 'Additive was successfully created.' }
        format.json { render :show, status: :created, location: @additive }
      else
        format.html { render :new }
        format.json { render json: @additive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /additives/1
  # PATCH/PUT /additives/1.json
  def update
    respond_to do |format|
      if @additive.update(additive_params)
        format.html { redirect_to @additive, notice: 'Additive was successfully updated.' }
        format.json { render :show, status: :ok, location: @additive }
      else
        format.html { render :edit }
        format.json { render json: @additive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /additives/1
  # DELETE /additives/1.json
  def destroy
    @additive.destroy
    respond_to do |format|
      format.html { redirect_to additives_url, notice: 'Additive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_additive
      @additive = Additive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def additive_params
      params.require(:additive).permit(:name)
    end
end
