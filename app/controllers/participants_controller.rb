class ParticipantsController < ApplicationController
    def create
      @participant = Participant.new(participants_params)
      @participant.activity = Activity.find(params[:activity_id])
      @participant.user = current_user 
      if @participant.save 
        flash[:success] = "Thank you for signing up to this event. Check your profile to see activities you have signed up for."
      	redirect_to activity_path(@participant.activity)
      else 
        flash[:error] = "You have already join this activity (check your profile), or please sign in to join"
        redirect_to activity_path(@participant.activity)
      end 
    end

    def destroy
      @participant = Participant.find(params[:id])
        if @participant.destroy 
        flash[:success] = "You have remove this user from this activity."
        redirect_to participants_path 
      end 
  	end

    def index 
      @participants = Participant.order(:id) 
    end 

  private 

  def participants_params 
    params.permit(
      :user_id, 
      :activity_id)
  end  
end



