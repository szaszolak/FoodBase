class ExperimentDefinitionsController < ApplicationController
  before_action :set_product
  def index
    @defintions = @product.experiment_definitions.all
  	@definition = @product.experiment_definitions.build
  end

  def create
  	 @definition = @product.experiment_definitions.build(definition_params)
  
    respond_to do |format|
      if @definition.save
        format.html{ redirect_to product_experiment_definitions_path(@product), success: 'Description was successfully created.' }
        #format.json { render :show, status: :created, location: @product }
      else
        format.html { redirect_to product_experiment_definitions_path(@product), danger: 'Błąd zapisu: '+ @definition.errors.to_a.join(", ") }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
     definition = ExperimentDefinition.find(params[:id])
   
  
     respond_to do |format|
     if definition.destroy
        @defintions = @product.experiment_definitions.all
        format.html{ redirect_to new_product_experiment_definition_path(@product), success: 'definition was destroyed' }
        format.js {}
      else
        format.html { redirect_to new_product_experiment_definition_path(@product),  danger: 'Błąd zapisu: '+ @defintion.errors.to_a.join(", ")}
      end
    end
  end

  private    
  def set_product
      @product = Product.find(params[:product_id])
   end
    # Never trust parameters from the scary internet, only allow the white list through.
   def definition_params
      params.require(:experiment_definition).permit(:metric_id,:repetitions,:series)
   end
end
