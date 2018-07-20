class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :vote]
  respond_to :js, :json, :html 

  	def index
    	@activities = Activity.order(:activity_date)
  	end

  	def show
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
	end 

	def update 
		if current_user.admin? 
    		@activity.update_attributes(activity_params)
        	redirect_to activity_path 
    	else 
    		render 'edit'
    	end 	
	end 

	def destroy
	    if @activity.destroy 
	      flash[:success] = "Successfully deleted activity."
	      redirect_to activities_path
	    else
		  flash.now[:danger] = 'You are unable to delete this activity.Please try again' 
	      redirect_to activities_path   
	    end 
	end

	def vote 
		# if not liked, then like it
		if !current_user.liked? @activity 
			@activity.liked_by current_user 

		# if liked, unlike it
		elsif current_user.liked? @activity 
			@activity.unliked_by current_user
		end 

		respond_to do |format| 
			format.json { head :no_content }
    		format.html { redirect_to :back }
    		format.js 
		end 
	end 


	private 

	def set_activity 
		@activity = Activity.find(params[:id])
	end 

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
