class AddFieldsToClubsAndCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :build_year, :string
    add_column :courses, :kind, :string
    add_column :courses, :greenfee_cost, :string
  end
end
