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
	  			import_samples_xls(spreadsheet.sheet(i),spreadsheet.sheets[i])
	   		end
	   		redirect_to products_path and return
   		end
   		render :new and return
 	end

	#private
	def update
		product = Product.find(params[:id])

		spreadsheet = Roo::Spreadsheet.open(params[:file].path)

	   		ActiveRecord::Base.transaction do
	   		product.recipes.destroy_all
			product.samples.destroy_all
			product.experiment_definitions.destroy_all
	   		import_product_xls(spreadsheet.sheet(0),product);	
	   		import_recipe_xls(spreadsheet.sheet(1));
		  		
		   	count = spreadsheet.sheets.count
			(2..count-1).each do |i|
	  			import_samples_xls(spreadsheet.sheet(i),spreadsheet.sheets[i])
	   		end
	   		redirect_to products_path and return
   		end
   		render :new and return
	end
	def import_product_xls(sheet,product=nil)

		@product = product||Product.new
		@category = Category.find_by_name(sheet.row(1)[1].downcase)
		unless @category
			@product.errors[:base]<<"Can not find following category: "+ sheet.row(1)[1]
		 	raise ActiveRecord::Rollback
		end 
		@product.category = @category
		#@product.attributes  = Hash[[clear_attributes_names(Product.column_names),sheet.row(3)].transpose];
		@product.name =sheet.row(3)[0]
		@product.description =sheet.row(3)[1]
		@product.article_url =sheet.row(3)[2]
		@product.save
		(7..sheet.count).each do |i|
			definition = @product.experiment_definitions.build
			definition.metric_id = Metric.find_by_name(sheet.row(i)[0]).id
			definition.series = sheet.row(i)[1]
			definition.repetitions = sheet.row(i)[2]
			definition.save
		end	

		
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

	def import_samples_xls(sheet,metric)

		sample_definition_rows_count = 4;
		
		definition = @product.experiment_definitions.joins(:metric).where("metrics.name=?",metric).first
		samples_count = sheet.row(2).count
		(1..samples_count-1).each do |i|

		analysys_data_start = 4;
			@additive = nil
	
			@additive = Additive.find_by_name(sheet.row(2)[i])

			if @additive
				@sample =  @product.samples.where("amount=? AND additive_id=? AND temperature=?",sheet.row(3)[i],@additive.id,sheet.row(4)[i]).first
				#sprawdź czy dany produkt nie posiada już takiej próbki
				unless @sample
					@sample = @product.samples.build
					@sample.additive = @additive
					@sample.amount = sheet.row(3)[i]
					@sample.temperature = sheet.row(4)[i]
					@sample.save
				end

 				 #mały hack wynikający ze struktury danych zwaracanych przez roo => zwraca tablicę tablic zawierających poszczególne wiersze.
  				(1..definition.series).each do |serie|
					import_sensory_analysis(sheet.column(i+1)[analysys_data_start,definition.repetitions],serie,definition) #kolumny numerowane od 1 a nie od zera, viva la spójne indeksowanie!
					analysys_data_start = (sample_definition_rows_count+ definition.repetitions + 2)*serie+sample_definition_rows_count; #+2 bo ignorowana jest srednia i wiersz przerwy
				end	
				
			else
				@sample.errors[:base]<<"Can not find following additive: "+ sheet.row(1)[0]
				raise ActiveRecord::Rollback
			end
			
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

	def import_sensory_analysis(column,serie,definition)

		metric = definition.metric

		if metric
			(1..definition.repetitions).each do |i|
				if column and column[i-1] != nil
					@analysis = @sample.sensory_analyses.build
					@analysis.repetition_id = i;
					@analysis.serie_id = serie
					@analysis.metric = metric;
					@analysis.value = column[i-1];
					@analysis.save
				end
			end
		else
			@sample.errors[:base]<<"Can not find following metric: "+ column.first.downcase
			raise ActiveRecord::Rollback
		end

	end
end
