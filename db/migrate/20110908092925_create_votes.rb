class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :question
      t.references :answer
      t.integer :value

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :question_id
    add_index :votes, :answer_id
  end
end
