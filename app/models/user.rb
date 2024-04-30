class User < ApplicationRecord
  has_secure_password
  
  has_many :classroom_enrollments
  has_many :classrooms, through: :classroom_enrollments
end
