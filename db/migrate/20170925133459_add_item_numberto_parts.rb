class AddItemNumbertoParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :item_num, :integer
  end
end
