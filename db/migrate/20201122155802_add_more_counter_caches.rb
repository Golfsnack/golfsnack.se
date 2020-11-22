class AddMoreCounterCaches < ActiveRecord::Migration[6.1]
  def change
    add_column :clubs, :posts_count, :integer
    add_column :clubs, :users_count, :integer

    Club.all.each do |club|
      Club.reset_counters(club.id, :posts)
      Club.reset_counters(club.id, :users)
    end

  end
end
