class RenameGuidesToArticles < ActiveRecord::Migration[6.0]
  def change
    rename_table :guides, :articles
  end
end
