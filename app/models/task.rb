class Task < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :classroom

  has_many :task_progresses
end
