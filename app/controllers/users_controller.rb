class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_login , except: [:index , :store]
  before_action :check_user , except: [:index , :store]
 
  
  def index
   if current_user
   redirect_to dashboard_index_path
   end
  
  end
  
  
  def store

   auth_hash = Hash.new
   auth_hash =request.env['omniauth.auth']
   if !current_user.present?
    @user = User.from_omniauth(request.env['omniauth.auth'])  
    if @user.present?
     session[:user_id] = @user.id
     flash[:notice] = "Welcome, #{@user.name}!"
     else
     flash[:alert] = "You are not authorize to login"
     end
 
   end    
     #Mailbox.from_omniauth(auth_hash, @user.id)   
     if current_user.present?
     
     	user = Mailbox.find_by_email(auth_hash['info']['email'])    
     	if !user.present?
     	user= Mailbox.new
     	end

		user.name = auth_hash['info']['name']
		user.user_id = current_user.id
		user.email = auth_hash['info']['email']		
		user.access_key = auth_hash['extra']['id_token']
		user.expire_at = auth_hash['credentials']['expires_at']
		user.refresh_token = auth_hash['credentials']['token']		
		if user.save
			#redirect_to mailboxes_index_path
		else
			
		 flash[:notice] = user.errors
		end
    end
   
 
	redirect_to dashboard_index_path
  end
  
  def destroy
  if current_user
    session.delete(:user_id)
    flash[:notice] = 'See you!'
  end
  redirect_to root_path
 end
 
  def show
  
  @users = User.all
  
  end
 
  def add_user
	@new = User.new
	if request.post?   

	 name = params[:first_name] + ' ' + params[:last_name]
	 email = params[:email] 
	 role = params[:role] 
	 
		 if @user = User.create(:name => name, :email => email, :status => true , :role =>role, :provider =>current_user.name,:uid => 'no')
			flash[:notice] = 'Done!'			
		 else
		flash[:error] =  @user.errors  	
		 end	
	
     redirect_to("/user/show")
	end
  end
  
  def edit_user
	if params[:id].present?
		@user = User.find_by_id(params[:id])
		if @user.present? && params[:first_name].present?
		    name = params[:first_name] + ' ' + params[:last_name]
			 email = params[:email] 
			 role = params[:role] 
		   if @user.update_attributes(:name => name, :email => email, :status => true , :role =>role)
		   flash[:notice] = "User updated"
		   redirect_to("/user/show")
		   else
		   flash[:error] = "Please Try Again" 
		   end
		end
	else
  	 flash[:error] = "Invalid User"  
  	 redirect_to("/user/show")
	end  
 end
 
  def delete_user
	if params[:id].present?
		@user = User.find_by_id(params[:id])
		if !@user.destroy
		   flash[:error] = "Action can not be performed"  
		end		
	else
  	 flash[:error] = "Invalid User"    	
	end  
	 redirect_to("/user/show")
 end
  
  
   
end
