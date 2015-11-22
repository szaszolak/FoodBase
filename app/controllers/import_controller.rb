require 'roo'
class ImportController < ApplicationController
	def new
	end

	def create
    	spreadsheet = Roo::Spreadsheet.open(params[:file])
   	
   		import_product_xls(spreadsheet.sheet(0));
   			if @product.errors.any?
   				render :new and return
   			end

   			import_recipe_xls(spreadsheet.sheet(1));

	   			if @recipe.errors.any?
	   				render :new and return
	   			end
	  
	   			count = spreadsheet.sheets.count
		   		(2..count-1).each do |i|

			   			import_samples_xls(spreadsheet.sheet(i))
			   			if @sample.errors.any?
			   				render :new and return
			   			end
		   			
   		end
   		#spreadsheet.each_with_pagename do |name, sheet|
 		# header = sheet.row(1)
 		# (2..sheet.last_row).each do |i|

 		# end
		#end
		redirect_to products_path

 	end

	#private

	def import_product_xls(sheet)
		@product = Product.new
		@product.attributes  = Hash[[clear_attributes_names(Product.column_names),sheet.row(2)].transpose];
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
				return
			end
		end
	end

	def import_samples_xls(sheet)
		#byebug
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
			(4..sheet.count).each do |i|
				@analysis = @sample.sensory_analyses.build
				@analysis.attributes = Hash[[clear_attributes_names(SensoryAnalysis.column_names),sheet.row(i)].transpose];
				@analysis.save
			end
		else
			@sample.errors[:base]<<"Can not find following ingredient: "+ sheet.row(1)[0]
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
end
