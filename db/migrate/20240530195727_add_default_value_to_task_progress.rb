class AddDefaultValueToTaskProgress < ActiveRecord::Migration[7.0]
  def change
    change_column_default :task_progresses, :progress, 0
  end
end
