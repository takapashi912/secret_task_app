class CreateQuestionTemplates < ActiveRecord::Migration[8.1]
  def change
    create_table :question_templates do |t|
      t.text :body

      t.timestamps
    end
  end
end
