class CreateGolfclubs < ActiveRecord::Migration[6.1]
  def change
    create_table :clubs do |t|
      t.string :import_guid
      t.string :name
      t.string :lat
      t.string :lng
      t.text :description
      t.timestamps
    end

    create_table :courses do |t|
      t.string :import_guid
      t.integer :club_id
      t.integer :import_id
      t.string :name
      t.integer :holes_count
      t.integer :par
      t.text :description
      t.string :architect
      t.timestamps
    end

    create_table :holes do |t|
      t.integer :course_id
      t.integer :number
      t.integer :par
      t.integer :index

      t.timestamps
    end
  end
end
