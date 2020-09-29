class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.string :email
      t.string :code
      t.datetime :claimed_at
      t.timestamps
    end

    add_index :invitations, :email, unique: true
  end
end
