class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.integer :jobNum
      t.datetime :poDate
      t.string :customer
      t.text :description
      t.boolean :needBom
      t.boolean :bomDone
      t.integer :status
      t.text :progress
      t.integer :priority

      t.timestamps
    end
  end
end
