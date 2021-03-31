# frozen_string_literal: true

class AddDefaultFalseToPollArchived < ActiveRecord::Migration[6.1]
  def change
    change_column :polls, :archived, :boolean, default: false

    Poll.all.each do |poll|
      poll.update_attribute(:archived, false)
    end
  end
end
