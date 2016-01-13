class RecipesController < ApplicationController
  before_action :set_up, only: [:index, :new, :create]
  def index
  end

  def new
  end

  def create
    @recipe = Recipe.new#(amount: params[:amount], product_id: params[:product_id], ingredient_id: params[:ingredient_id])
    @recipe.amount = recipe_params[:amount]
    @recipe.product_id = params[:product_id]
    @recipe.ingredient_id = recipe_params[:ingredient_id]
    byebug
    respond_to do |format|
      if @recipe.save
        format.html{ redirect_to product_recipes_path(@product)}
        format.js {}
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render action: "index", notice: 'error.' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    @product = Product.find(params[:product_id])
    recipe.destroy
    @recipes = @product.recipes.order(created_at: :desc)
     respond_to do |format|
        format.html{ redirect_to product_recipes_path(@product)}
        format.js {}
    end
  end

  def update
  end

  def show
  end

  private
  def set_up
    @product = Product.find(params[:product_id])
    @recipes = @product.recipes.order(created_at: :desc)
    @recipe = @product.recipes.build
  end

   def recipe_params
      params.require(:recipe).permit(:amount, :product_id,:ingredient_id)
    end
 
end
