class AddPreambleToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :preamble, :text
    add_column :articles, :preamble, :text
  end
end
