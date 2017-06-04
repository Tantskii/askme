class CreateHashtagQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :hashtag_questions do |t|
      t.integer :hashtag_id
      t.integer :question_id

      t.timestamps
    end
    add_index :hashtag_questions, [:hashtag_id, :question_id], unique: true
  end
end
