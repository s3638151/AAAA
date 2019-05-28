class CreateCategoriesCoursesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :courses
  end
end
