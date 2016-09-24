class CreateCalenderEvents < ActiveRecord::Migration
  def change
    create_table :calender_events do |t|
      t.string :event_id
      t.string :summary
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.integer :mailbox_id

      t.timestamps
    end
  end
end
