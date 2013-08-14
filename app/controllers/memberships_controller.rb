class MembershipsController < ApplicationController
  def create
    @company = Company.find(params[:membership][:company_id])
    current_user.join_company!(@company)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    #@user = User.find(Membership.find(params[:id]).user_id)
    @company = Company.find(Membership.find(params[:id]).company_id)
    current_user.leave_company!(@company)
    unless @company.memberships.any?
      @company.destroy 
    end
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  private
    def user_params
      params.require(:user).permit(:followed_id, :follower_id)
    end
end