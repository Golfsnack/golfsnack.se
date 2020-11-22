class AddClubIdToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :club_id, :integer
  end
end
