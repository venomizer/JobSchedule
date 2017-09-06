class ChangepoDateToDate < ActiveRecord::Migration[5.1]
  def change
    change_table :jobs do |t|
      t.change(:poDate, :date)
    end
  end
end
