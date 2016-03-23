class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end


  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to ingredients_url, success: 'Składnik został pomyślnie utworzony' }
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
        format.html { redirect_to ingredients_url, success: 'Składnik został pomyślnie usunięty.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html {  redirect_to ingredients_url, danger: 'Składnik  nie został usunięty: '+@ingredient.errors.to_a.join(', ') }
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
        @ingredient = Ingredient.find(params[:id])
  end

 def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
