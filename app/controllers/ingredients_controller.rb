class IngredientsController < ApplicationController
  def index
  end

  def new
    @ingredient = Ingredient.new
  end


  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @ingredient = Ingredient.find(params[:id])
    respond_to do |format|
      if @ingredient.destroy
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully destroyed.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :index }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
        @ingredient = Ingredient.find(params[:id])
        @ingredient.name = ingredient_params[:name]
        @ingredient.save
  end

  def show
  end

 def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
