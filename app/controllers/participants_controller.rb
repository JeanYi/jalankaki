class ParticipantsController < ApplicationController
    def create
      @participant = Participant.new(participants_params)
      @participant.activity = Activity.find(params[:activity_id])
      @participant.user = current_user 
      if @participant.save 
      	redirect_to activities_path 
      else 
        flash[:error] = "You have already join this activity, or please sign in to join"
        redirect_to activities_path 
      end 
    end

    def destroy
      @participant = Participant.where(activity_id: params[:activity_id], participant_id: params[:id])[0].destroy()
      redirect_to Activity.find(params[:activity_id])
  	end

  private 

  def participants_params 
    params.permit(
      :user_id, 
      :activity_id)
  end  
end



