class AddDateLimitToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :date_limit, :date
  end
end
