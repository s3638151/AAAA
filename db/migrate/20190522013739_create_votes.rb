class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true

      t.integer :vote

      t.timestamps
    end
  end
end
