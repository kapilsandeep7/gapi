class AddStatusColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :status, :boolean
    add_column :users, :role, :integer
  end
end
