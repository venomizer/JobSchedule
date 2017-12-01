class CreatePumps < ActiveRecord::Migration[5.1]
  def change
    create_table :pumps do |t|
      t.string :product_type
      t.integer :stages
      t.integer :flowrate
      t.integer :dev_head
      t.string :assembly
      t.text :restrictions

      t.timestamps
    end
  end
end
