class ChangeAccessKeyTypeInMailbox < ActiveRecord::Migration
  def change
  change_column :mailboxes, :access_key, :text
  end
end
