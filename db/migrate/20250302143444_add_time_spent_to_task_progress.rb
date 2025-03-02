class AddTimeSpentToTaskProgress < ActiveRecord::Migration[7.0]
  def change
    add_column :task_progresses, :time_spent, :integer, default: 0
  end
end
