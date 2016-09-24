class EmailMessagesController < ApplicationController
 require 'google/apis/gmail_v1'
  before_action :check_login 
  CC_EMAIL = "kapilsandeep7@gmail.com"
  def index
	if params[:id].present?
      @message_list = EmailMessage.where(:mailbox_id => params[:id] )
   end
  end
  
  def fetch_messages

   if params[:id].present?
    @mailboxes = Mailbox.where(:id => params[:id]).first
#	time1 = Date.parse(@mailboxes.expire_at)
 #  if  time1.strftime( "%H%M%S%N" ) < Time.now.strftime( "%H%M%S%N" )
	   response    = HTTPClient.post "https://accounts.google.com/o/oauth2/token", :grant_type => 'refresh_token', :refresh_token => @mailboxes.refresh_token, :client_id => ENV["google_client_id"], :client_secret => ENV["google_client_secret"] 	
	   refreshhash = JSON.parse(response.body)
	
	   if  refreshhash['access_token'].present?
		   @mailboxes.refresh_token = refreshhash["access_token"]
		   @mailboxes.expire_at = Time.now.utc + refreshhash["expires_in"].to_i.seconds
		   @mailboxes.save!
	   end
  # end	   
   token = refreshhash.present? ? refreshhash['access_token']  : @mailboxes.refresh_token
    client = Signet::OAuth2::Client.new(access_token: token)
    client.expires_in = Time.now + 1_000_000
  
  service = Google::Apis::GmailV1::GmailService.new
  
    
		service.authorization = client
		if service.authorization.access_token.present?
	    message_list = service.list_user_messages('me', q: "cc:#{CC_EMAIL}")
	    
		#abort(message_list.messages.inspect)

		 message_list.messages.each do |msg|
        @msg_id=msg.id
		result = service.get_user_message('me',msg.id)
		@body = result.payload.parts.present? ? result.payload.parts[0].body.data : 'N/A'
		@data = result
		hash = Hash.new
		result.payload.headers.each do |hedr|
			hash[hedr.name] = hedr.value			
		end
		from = hash['From']
		date = hash['Date']
		subject = hash['Subject']
		EmailMessage.create(:message_id =>@msg_id, :from => from, :to => @mailboxes.email, :subject => subject, :body => @body, :date => date, :mailbox_id => @mailboxes.id )
		end
		
	flash[:notice] = "message feteched successfuly"  
    redirect_to("/email_messages/"+params[:id]) and return
		#labels_list = service.list_user_labels('me')
		else
		 flash[:alert] = "Please authorize again"  
    redirect_to("/mailboxes/index")
		end
		
   else
    flash[:alert] = "Invalid User"  
    redirect_to("/mailboxes/index")
   end
   
   
  
end

   
end
