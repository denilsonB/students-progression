class RemoveDefaultGradeLevelFromTask < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:tasks, :grade_level, nil)
  end
end
