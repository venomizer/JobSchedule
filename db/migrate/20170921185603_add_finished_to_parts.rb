class AddFinishedToParts < ActiveRecord::Migration[5.1]
  def change
    add_column :parts, :finished, :boolean
  end
end
