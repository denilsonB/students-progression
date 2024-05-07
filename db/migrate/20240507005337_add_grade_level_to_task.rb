class AddGradeLevelToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :grade_level, :integer, default: 0
  end
end
