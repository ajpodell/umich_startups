class UsersController < ApplicationController
  before_filter :signed_in_user,
                  only: [:show, :index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]              
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
	  	# flash[:success] = "Flash test"
  		redirect_to @user
  	else 
  		render 'new'
  	end
  end

  def show
    @user = User.find(params[:id])
    @companies = @user.companies.paginate(page: params[:page], per_page: 1)
  end

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update_attributes(user_params)
        #Handle a successful update
        flash[:success] = "Profile updated"
        sign_in @user
        redirect_to @user
    else
        render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "#{user.name} has been deleted from the system"
    redirect_to users_url
  end

  def following
    @title = "Connections"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_connect'
  end

  def followers
    @title = "Connected Users"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_connect'
  end

  def memberships
    #find and display companies via memberships
    @user = User.find(params[:id])
    @memberships = @user.memberships.paginate(page: params[:page])
    @companies = []
    @memberships.each { |m| @companies.push Company.find(m.company_id) }
    @companies = @companies.paginate(page: params[:page])
    render 'show_companies'
  end


  private

    def user_params
        params.require(:user).permit(:name, :email, :password, :photo, :major,
                                     :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
