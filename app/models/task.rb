class Task < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :classroom

  has_many :task_progresses
  has_many :feedbacks

  enum grade_level: { fifth_grade: 0, sixth_grade: 1, seventh_grade: 2, eighth_and_nineth_grade: 3,tenth_to_twelveth_grade: 4, college: 5, college_graduate: 6, professional: 7 }
  validates :grade_level, presence: true
end
