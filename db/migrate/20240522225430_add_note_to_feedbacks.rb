class AddNoteToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :avaliation, :integer
  end
end
