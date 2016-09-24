class EmailMessage < ActiveRecord::Base
belongs_to :mailbox
validates :mailbox_id, presence: { message: 'Please enter '  }
validates :message_id, presence: { message: 'Please enter '  }
validates :mailbox_id, presence: { message: 'mailbox can not be blank '  }
validates :message_id, uniqueness: true 
end
