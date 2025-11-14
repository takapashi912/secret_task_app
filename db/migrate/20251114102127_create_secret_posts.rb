class CreateSecretPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :secret_posts do |t|
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
