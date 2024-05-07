class AddGradeLevelToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :grade_level, :integer, default: 0
  end
end
