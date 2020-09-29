class CreateGuides < ActiveRecord::Migration[6.0]
  def change
    create_table :guides do |t|
      t.integer :user_id

      t.string :title
      t.string :image
      t.text :body

      t.timestamps
    end
  end
end
