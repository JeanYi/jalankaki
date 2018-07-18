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

end


# Session isn’t an Active Record model. Instead, we’ll put a message in the flash
# to be displayed upon failed login. The contents of flash.now disappear as soon 
# as there is an additional request