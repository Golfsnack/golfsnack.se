# frozen_string_literal: true

class CreatePollQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :poll_questions do |t|
      t.integer :poll_id
      t.string :choice
      t.timestamps
    end
  end
end
