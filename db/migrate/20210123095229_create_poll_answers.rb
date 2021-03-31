# frozen_string_literal: true

class CreatePollAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :poll_answers do |t|
      t.integer :poll_id
      t.integer :poll_question_id
      t.integer :user_id
      t.timestamps
    end
  end
end
