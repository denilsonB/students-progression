class CreateClassroomEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :classroom_enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
