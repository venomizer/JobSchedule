class Pump < ApplicationRecord
  before_create :update_pump_item_num
  before_destroy :update_pump_item_num
  belongs_to :job

  private
  def update_pump_item_num
    if self.new_record?
      self.item_num = self.class.where('job_id = ?', self.job_id).count.to_i+1
    else
      nil
    end

    if self.destroyed?
      self.class.where('item_num > ?', self.item_num_was).update_all('item_num = item_num - 1')
    else
      nil
    end
  end
end
