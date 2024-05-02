class TaskProgress < ApplicationRecord
  belongs_to :user
  belongs_to :task
  before_save :set_progress_to_100

  def set_progress_to_100
    return unless self.progress == 85
    self.update_column(:progress, 100)
  end
end
