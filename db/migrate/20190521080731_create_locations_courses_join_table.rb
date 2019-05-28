class CreateLocationsCoursesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :locations, :courses
  end
end
