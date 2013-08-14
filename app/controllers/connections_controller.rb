class ConnectionsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:connection][:followed_id])
    current_user.follow!(@user)
    # flash[:success] = "You are now following #{@user.name.split[0]}"
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Connection.find(params[:id]).followed
    current_user.unfollow!(@user)
    # flash[:success] = "You are no longer following #{@user.name}"
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private
    def user_params
      params.require(:user).permit(:followed_id, :follower_id)
    end
end
