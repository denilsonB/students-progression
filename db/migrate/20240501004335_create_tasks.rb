class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :classroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
