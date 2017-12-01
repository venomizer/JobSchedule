class AddTypeToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :work_type, :string
  end
end
