class MailboxesController < ApplicationController

  protect_from_forgery with: :exception
  before_action :check_login 
  #before_action :check_user 
  def index
  
  @mailboxes = Mailbox.where(:user_id => current_user.id)
  #abort(@mailboxes.inspect)
  #@calendar_list = Mailbox.query_google(@mailboxes.refresh_token)
  
  end

  def show
  end

  def create
  end

   def delete
	if params[:id].present?
		@user = Mailbox.find_by_id(params[:id])
		if !@user.destroy
		   flash[:warning] = "Action can not be performed"  
		end		
	else
  	 flash[:warning] = "Invalid User"    	
	end  
	 redirect_to("/mailboxes/index")
 end
end
