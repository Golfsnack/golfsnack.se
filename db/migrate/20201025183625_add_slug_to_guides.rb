class AddSlugToGuides < ActiveRecord::Migration[6.0]
  def change
    add_column :guides, :slug, :string
    add_index :guides, :slug, unique: true
  end
end
