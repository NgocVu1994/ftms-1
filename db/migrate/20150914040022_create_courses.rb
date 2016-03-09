class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.integer :status, default: 0
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end
