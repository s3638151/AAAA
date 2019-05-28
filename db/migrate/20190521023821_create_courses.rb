class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :prerequisite
      t.string :description
      t.string :image
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
