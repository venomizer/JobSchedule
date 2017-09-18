class CreateParts < ActiveRecord::Migration[5.1]
  def change
    create_table :parts do |t|
      t.string :partNum
      t.text :description
      t.integer :quanitity
      t.integer :totalQuantity
      t.string :workOrder
      t.boolean :finish

      t.timestamps
    end
  end
end
