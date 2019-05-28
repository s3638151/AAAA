class AddTypeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :types, :integer, default:0
  end
end
