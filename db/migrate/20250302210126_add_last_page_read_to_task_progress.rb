class AddLastPageReadToTaskProgress < ActiveRecord::Migration[7.0]
  def change
    add_column :task_progresses, :last_page_read, :integer, default: 0
  end
end
