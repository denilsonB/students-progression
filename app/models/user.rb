class User < ApplicationRecord
  has_secure_password

  has_many :classroom_enrollments
  has_many :classrooms, through: :classroom_enrollments
  has_many :task_progresses

  enum grade_level: { fifth_grade: 0, sixth_grade: 1, seventh_grade: 2, eighth_and_nineth_grade: 3,tenth_to_twelveth_grade: 4, college: 5, college_graduate: 6, professional: 7 }
end
