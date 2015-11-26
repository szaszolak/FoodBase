class ChangeColumnOrderInProducts < ActiveRecord::Migration
  def change

  		change_column :products, :name, :string, after: :id

  end
end
