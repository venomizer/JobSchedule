class AddQuantityToPumps < ActiveRecord::Migration[5.1]
  def change
    add_column :pumps, :quantity, :integer
  end
end
