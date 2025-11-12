class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question_template, foreign_key: true
      t.string :title, null: false
      t.datetime :due_at, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end

  end
end
