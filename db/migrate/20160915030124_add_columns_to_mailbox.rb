class AddColumnsToMailbox < ActiveRecord::Migration
  def change
    add_column :mailboxes, :refresh_token, :string
    add_column :mailboxes, :expire_at, :string
    add_column :mailboxes, :access_key, :string
  end
end
