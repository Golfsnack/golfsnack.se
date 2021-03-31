# frozen_string_literal: true

class AddDiscardedAtToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :discarded_at, :datetime
    add_index :posts, :discarded_at

    add_column :users, :discarded_at, :datetime
    add_index :users, :discarded_at

    add_column :comments, :discarded_at, :datetime
    add_index :comments, :discarded_at
  end
end
