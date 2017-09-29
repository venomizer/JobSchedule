class ChangeFinishedNull < ActiveRecord::Migration[5.1]
  def change
    change_column_default :jobs, :finished, false
    change_column_default :parts, :finished, false
  end
end
