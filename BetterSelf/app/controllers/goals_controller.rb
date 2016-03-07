class GoalsController < ApplicationController

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.save
    flash[:errors] = @goal.errors.full_messages
    redirect_to user_url(current_user)
  end


  private
  def goal_params
    params.require(:goal).permit(:description, :share_goal)
  end
end
