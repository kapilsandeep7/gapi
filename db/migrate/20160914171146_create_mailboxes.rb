class CreateMailboxes < ActiveRecord::Migration
  def change
    create_table :mailboxes do |t|
      t.integer :user_id, null: false
      t.string :name ,null: false
      t.string :email, null: false
      t.boolean :status , default: false

      t.timestamps
    end
  end
end
