class MoveNameCollumnToFirstPlaceInProduct < ActiveRecord::Migration
 def up
  change_column :products, :name, :string, after: :id
end
end
