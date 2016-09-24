class User < ActiveRecord::Base
validates :email, presence: { message: 'Please enter email'  }
validates :email, uniqueness: true 
has_many :mailbox
def self.from_omniauth(auth_hash)
    user = find_by_email(auth_hash['info']['email'])
    if user.present?
		#user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
		user.uid = auth_hash['uid']
		user.provider = auth_hash['provider']
		user.name = auth_hash['info']['name']
		user.email = auth_hash['info']['email']
		user.location = auth_hash['info']['location']
		user.image_url = auth_hash['info']['image']
		user.url = auth_hash['info']['urls']['Google']
		user.access_token = auth_hash['extra']['id_token']
		user.save!
		user
		
	end	
  end
  
end
