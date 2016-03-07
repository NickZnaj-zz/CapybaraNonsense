class GoalsController < ApplicationController

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.save
    flash[:errors] = @goal.errors.full_messages
    redirect_to user_url(current_user)
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update_attributes(goal_params)
    #fail
    flash[:errors] = @goal.errors.full_messages
    redirect_to user_url(@goal.user_id)


  end


  private
  def goal_params
    params.require(:goal).permit(:description, :share_goal, :completed)
  end
end
