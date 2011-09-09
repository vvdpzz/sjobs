class CreateWatchedQuestions < ActiveRecord::Migration
  def change
    create_table :watched_questions do |t|
      t.references :user, :null => false
      t.references :question, :null => false
      t.boolean :status, :null => false, :default => true

      t.timestamps
    end
    add_index :watched_questions, :user_id
    add_index :watched_questions, :question_id
  end
end
