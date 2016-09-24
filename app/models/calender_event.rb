class CalenderEvent < ActiveRecord::Base
belongs_to :mailbox
validates :mailbox_id, presence: { message: 'mailbox can not be blank '  }
validates :event_id, presence: { message: 'event id can not be blank '  }
validates :event_id, uniqueness: true 
end
