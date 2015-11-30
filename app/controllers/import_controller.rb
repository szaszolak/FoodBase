require 'roo'
class ImportController < ApplicationController
	def new
	end
	def edit
		@product = Product.find(params[:id])
	end
	def create
    	spreadsheet = Roo::Spreadsheet.open(params[:file].path)

	   		ActiveRecord::Base.transaction do
	   		import_product_xls(spreadsheet.sheet(0));	
	   		import_recipe_xls(spreadsheet.sheet(1));
		  		
		   	count = spreadsheet.sheets.count
			(2..count-1).each do |i|
	  			import_samples_xls(spreadsheet.sheet(i))
	   		end
	   		redirect_to products_path and return
   		end
   		render :new and return
 	end

	#private
	def update
		product = Product.find(params[:id])
		product.recipes.destroy
		product.samples.destroy
		spreadsheet = Roo::Spreadsheet.open(params[:file].path)

	   		ActiveRecord::Base.transaction do
	   		import_product_xls(spreadsheet.sheet(0),product);	
	   		import_recipe_xls(spreadsheet.sheet(1));
		  		
		   	count = spreadsheet.sheets.count
			(2..count-1).each do |i|
	  			import_samples_xls(spreadsheet.sheet(i))
	   		end
	   		redirect_to products_path and return
   		end
   		render :new and return
	end
	def import_product_xls(sheet,product)

		@product = product||Product.new
		@category = Category.find_by_name(sheet.row(1)[1].downcase)
		unless @category
			@product.errors[:base]<<"Can not find following category: "+ sheet.row(1)[1]
		 	raise ActiveRecord::Rollback
		end 
		@product.category = @category
		@product.attributes  = Hash[[clear_attributes_names(Product.column_names),sheet.row(3)].transpose];
		@product.save
	end
	
	def import_recipe_xls(sheet)

		ingredients = sheet.row(1)
		values = sheet.row(2)
		(0..ingredients.count-1).each do |i|
			ingredient = Ingredient.find_by_name(ingredients[i])
			if ingredient
				@recipe = Recipe.new
				@recipe.product = @product
				@recipe.ingredient = ingredient
				@recipe.amount = values[i];
				@recipe.save
			else
				@recipe.errors[:base]<<"Can not find following ingredient: "+ ingredients[i]
				raise ActiveRecord::Rollback
			end
		end
	end

	def import_samples_xls(sheet)

		@additive = nil
		@sample = nil
		@additive = Additive.find_by_name(sheet.row(1)[0])
		@analysis=nil
		@sample = Sample.new
		if @additive
			@sample.product = @product
			@sample.additive = @additive
			@sample.amount = sheet.row(2)[0]
			@sample.temperature = sheet.row(2)[1]
			@sample.save
			(1..sheet.first.count).each do |i|  #mały hack wynikający ze struktury danych zwaracanych przez roo => zwraca tablicę tablic zawierających poszczególne wiersze.
				import_sensory_analysis(sheet.column(i)[2,sheet.column(i).count])
			end
		else
			@sample.errors[:base]<<"Can not find following ingredient: "+ sheet.row(1)[0]
			raise ActiveRecord::Rollback
		end
	end

	def clear_attributes_names(names) #remove foreing keys, id and autofilled columns
		result = [];
		names.each do |name|
			unless name.include?('_id') or name.include?('created_at') or name.include?('updated_at') or name == 'id'
				result<<name
			end
		end
		result
	end

	def import_sensory_analysis(column)

		@metric = Metric.find_by_name(column.first.downcase.strip)

		if @metric
			(1..column.count-1).each do |i|
				@analysis = @sample.sensory_analyses.build
				@analysis.repetition_id = i;
				@analysis.metric = @metric;
				@analysis.value = column[i];
				@analysis.save
			end
		else
			@sample.errors[:base]<<"Can not find following metric: "+ column.first.downcase
			raise ActiveRecord::Rollback
		end

	end
end
