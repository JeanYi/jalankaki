class ActivitiesController < ApplicationController

  	def index
    	@activities = Activity.order(:activity_date)
  	end

  	def show
  		@activity = Activity.find(params[:id])
  	end

  	def new 
  		if current_user.admin?
  			@activity = Activity.new 
  		else
    		flash.now[:danger] = 'You are not allowed to create an activity' 
  		end 
	end 

	def create 
		if current_user.admin? 
			@activity = Activity.new(activity_params)
			if @activity.save 
				redirect_to activities_path 
			else 
				render 'new'
			end 

		else 
			redirect_to root_path 
		end 
	end 

	def edit 
		@activity = Activity.find(params[:id])
	end 

	def update 
		@activity = Activity.find(params[:id])
		if current_user.admin? 
    		@activity.update_attributes(activity_params)
        	redirect_to activity_path 
    	else 
    		render 'edit'
    	end 	
	end 


	private 

	def activity_params 
		params.require(:activity).permit(
			:activity, 
			:title,
			:location,
			:studio,
			:description,
			:activity_date,
			:start_time,
			:end_time, 
			:hosted_by,
			:winner, 
			{images: []},
			:user_id)
	end  
end
