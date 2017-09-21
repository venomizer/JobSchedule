class Job < ApplicationRecord
  before_validation :update_priorities
  before_update :update_priorities
  validates :priority, :jobNum, uniqueness: true
  has_many :parts
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
