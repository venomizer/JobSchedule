class Job < ApplicationRecord
  validates :jobNum, uniqueness: true
  default_scope{ order('priority ASC')}

  private
end
