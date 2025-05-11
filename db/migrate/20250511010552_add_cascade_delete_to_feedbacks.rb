class AddCascadeDeleteToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :feedbacks, :tasks
    add_foreign_key :feedbacks, :tasks, on_delete: :cascade
  end
end
