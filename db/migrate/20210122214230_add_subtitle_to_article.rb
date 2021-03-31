# frozen_string_literal: true

class AddSubtitleToArticle < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :subitle, :string
  end
end
