class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :access_token, :text
  end
end
