class AddJobsForeignKey < ActiveRecord::Migration[5.1]
  def change
    add_reference :parts, :job, index: true
  end
end
