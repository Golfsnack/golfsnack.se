class CreatePolls < ActiveRecord::Migration[6.1]
  def change
    create_table :polls do |t|
      t.string :name
      t.boolean :archived
      t.timestamps
    end
  end
end
