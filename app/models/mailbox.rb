class Mailbox < ActiveRecord::Base
belongs_to :user
validates :email, presence: { message: 'Please enter email'  }
validates :email, uniqueness: true 
def self.from_omniauth(auth_hash, user_id)

		user = find_or_create_by(email: auth_hash['email'])
		user.name = auth_hash['info']['name']
		user.user_id = user_id
		user.email = auth_hash['info']['email']		
		user.access_key = auth_hash['extra']['id_token']
		user.expire_at = auth_hash['credentials']['expire_at']
		user.refresh_token = auth_hash['credentials']['token']		
		user.save!
		user

 end
  
def self.query_google( access_key )  
  
    require 'google/apis/gmail_v1'
    require 'google/apis/calendar_v3'
    response    = HTTPClient.post "https://accounts.google.com/o/oauth2/token", :grant_type => 'refresh_token', :refresh_token => access_key, :client_id => ENV["google_client_id"], :client_secret => ENV["google_client_secret"] 
    refreshhash = JSON.parse(response.body)
   # abort(refreshhash.inspect)
 
=begin	
      client = Signet::OAuth2::Client.new(access_token: refreshhash['access_token'])
      client.expires_in = Time.now + 1_000_000
		service = Google::Apis::GmailV1::GmailService.new
		service.authorization = client
		#message_list = service.list_user_messages('me')
		#abort(message_list.inspect)
		#message_list = service.get_user_message('me',"1572df492a8927fb")
		#abort(message_list['@body'].inspect)
		labels_list = service.list_user_labels('me')
=end
		#code for calender
	
		client = Signet::OAuth2::Client.new(access_token: refreshhash['access_token'])
      client.expires_in = Time.now + 1_000_000
      
      service = Google::Apis::CalendarV3::CalendarService.new
	  service.authorization = client
	  
	  calendar_id = 'primary'
      result = service.list_events(calendar_id,
                                 max_results: 10,
                                 single_events: true,
                                 order_by: 'startTime',
                                 time_min: Time.now.iso8601)
       result                          
   	
		

end


end
