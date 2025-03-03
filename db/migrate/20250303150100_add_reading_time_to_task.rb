class AddReadingTimeToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :reading_time, :integer, default: 0
  end
end
