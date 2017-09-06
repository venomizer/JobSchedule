class ChangeStatustoString < ActiveRecord::Migration[5.1]
  def change
    change_table :jobs do |t|
      t.change(:status, :string)
    end
  end
end
