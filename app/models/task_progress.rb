class TaskProgress < ApplicationRecord
  belongs_to :user
  belongs_to :task

  def add_time_spent(seconds)
    update(time_spent: time_spent + seconds)
  end
end
