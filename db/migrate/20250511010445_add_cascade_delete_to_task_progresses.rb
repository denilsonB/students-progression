class AddCascadeDeleteToTaskProgresses < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :task_progresses, :tasks
    add_foreign_key :task_progresses, :tasks, on_delete: :cascade
  end
end
