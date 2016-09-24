class CalenderEventsController < ApplicationController
  require 'google/apis/calendar_v3'
  before_action :check_login 
 
 
  def index
  
   if params[:id].present?
      @calendar_list = CalenderEvent.where(:mailbox_id => params[:id] )
   end
   
  end
  
  def fetch_events
  
  if params[:id].present?
   @mailboxes = Mailbox.where(:id => params[:id]).first 
   response    = HTTPClient.post "https://accounts.google.com/o/oauth2/token", :grant_type => 'refresh_token', :refresh_token => @mailboxes.refresh_token, :client_id => ENV["google_client_id"], :client_secret => ENV["google_client_secret"] 
   refreshhash = JSON.parse(response.body)
    if  refreshhash['access_token'].present?
        @mailboxes.refresh_token = refreshhash["access_token"]
	   @mailboxes.expire_at = Time.now.utc + refreshhash["expires_in"].to_i.seconds
       @mailboxes.save!
   end
  client = Signet::OAuth2::Client.new(access_token: refreshhash['access_token'])
  client.expires_in = Time.now + 1_000_000  
  service = Google::Apis::CalendarV3::CalendarService.new
  service.authorization = client
  
  if service.authorization.access_token.present?
	  calendar_id = 'primary'
		tym = Time.now - 1.month   
		tym2 = Time.now + 7.days   
	  @calendar_list = service.list_events(calendar_id,
								 max_results: 10,
								 single_events: true,
								 order_by: 'startTime',
								 time_min: tym.iso8601,
								 time_max: tym2.iso8601,)
		if !@calendar_list.blank?			
		@calendar_list.items.each do |calendar|
		 sdate = calendar.start.date.present? ? calendar.start.date : calendar.start.date_time
		 edate = calendar.end.date.present? ? calendar.end.date : calendar.end.date_time
				CalenderEvent.create(:event_id=> calendar.id, :summary => calendar.summary, :location => calendar.start.time_zone, :start_date => sdate, :end_date => edate, :status => calendar.status, :mailbox_id => params[:id])
		 end
		end	
			 
  flash[:notice] = "Event feteched successfuly"  
  redirect_to("/calender_events/"+params[:id]) and return
  else
		 flash[:alert] = "Please authorize again"  
         
		end
  else
    flash[:alert] = "Invalid User"  
   
   
   end
  
  redirect_to("/mailboxes/index")
  
  end
end
