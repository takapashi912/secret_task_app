class AddIndexesToTasks < ActiveRecord::Migration[8.1]
  def change
    add_index :tasks, [:user_id, :due_at]
    add_index :tasks, :status
  end
end
