class AddDueDateToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :dueDate, :date
  end
end
