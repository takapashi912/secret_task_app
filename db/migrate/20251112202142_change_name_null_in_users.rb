class ChangeNameNullInUsers < ActiveRecord::Migration[8.1]
  def up
    # ① 既に name が NULL のユーザーに、仮の名前を入れる
    execute <<~SQL
      UPDATE users
      SET name = '名無しユーザー'
      WHERE name IS NULL;
    SQL

    # ② そのうえで NOT NULL 制約を付ける
    change_column_null :users, :name, false
  end

  def down
    change_column_null :users, :name, true
  end
end
