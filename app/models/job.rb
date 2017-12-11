class Job < ApplicationRecord
  before_save :update_priorities
  validates :priority, :jobNum, uniqueness: true
  has_many :parts, -> { order(item_num: :asc)}, dependent: :destroy
  has_many :pumps, dependent: :destroy
  default_scope{ order('priority ASC')}

  private
  def update_priorities
    if self.priority_was == nil
      self.class.where('priority >= ?', self.priority).update_all('priority = priority + 1')
    else
      nil
    end

    if self.priority_changed? and self.priority_was != nil
      if self.priority < self.priority_was
        self.class.where('priority >= ?', self.priority).update_all('priority = priority + 1')
        self.class.where('priority > ?', self.priority_was).update_all('priority = priority - 1')
      else
        nil
      end

      if self.priority > self.priority_was
        self.class.where('priority <= ?', self.priority).update_all('priority = priority - 1')
        self.class.where('priority < ?', self.priority_was).update_all('priority = priority + 1')
      else
        nil
      end
    end
  end
end
