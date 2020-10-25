class AddMissingIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :invitations, :user_id
    add_index :posts, :user_id
  end
end
