class ClassroomEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :classroom
end
