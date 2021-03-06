# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
 Rails.application.config.assets.precompile += %w( charts/bar.js )
 Rails.application.config.assets.precompile += %w( charts/bar_compare.js )
 Rails.application.config.assets.precompile += %w( compare_show.js )
['additives','application','categories', 'compare', 'experiment_definitions', 'import', 'ingredients', 'media' ,'metrics', 'products', 'recipes','samples','sensory_analyses','pages'].each do |controller|
 Rails.application.config.assets.precompile += [controller+".js"]
end