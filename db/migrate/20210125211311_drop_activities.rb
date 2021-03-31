# frozen_string_literal: true

class DropActivities < ActiveRecord::Migration[6.1]
  def change
    drop_table :activities
  end
end
