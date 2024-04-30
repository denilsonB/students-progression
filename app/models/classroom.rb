class Classroom < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :classroom_enrollments
  has_many :users, through: :classroom_enrollments
end
