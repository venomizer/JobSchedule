class AddItemNumToPumps < ActiveRecord::Migration[5.1]
  def change
    add_column :pumps, :item_num, :integer
  end
end
