class SessionsController < ApplicationController
	
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
     	log_in user 
     	redirect_to root_path 
    else 
    	flash.now[:danger] = 'Invalid email/password combination' 
  		render 'new'
  	end 
  end 

  def destroy 
  	log_out  
	redirect_to root_path
  end 

  def create_from_omniauth
  	auth_hash = request.env["omniauth.auth"]
  	authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

  # if: previously already logged in with OAuth
  if authentication.user
    user = authentication.user
    authentication.update_token(auth_hash)
    @next = root_path 
    @notice = "Signed in!"
  # else: user logs in with OAuth for the first time
  else
    user = User.create_with_auth_and_hash(authentication, auth_hash)
    # you are expected to have a path that leads to a page for editing user details
    @next = edit_user_path(user)
    @notice = "User created. Please confirm or edit details"
  end
  	log_in(user)
  	redirect_to @next, :notice => @notice
  end


end

# Session isn’t an Active Record model. Instead, we’ll put a message in the flash
# to be displayed upon failed login. The contents of flash.now disappear as soon 
# as there is an additional request
# Request.env["omniauth.auth"] returns data about the user in an authentication hash