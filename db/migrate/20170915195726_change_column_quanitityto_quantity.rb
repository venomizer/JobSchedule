class ChangeColumnQuanititytoQuantity < ActiveRecord::Migration[5.1]
  def change
    remove_column :parts, :quanitity
    add_column :parts, :quantity, :integer
  end
end
