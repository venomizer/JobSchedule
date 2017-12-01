class AddJobsForeignKeyToPumps < ActiveRecord::Migration[5.1]
  def change
    add_reference :pumps, :job, index: true
  end
end
