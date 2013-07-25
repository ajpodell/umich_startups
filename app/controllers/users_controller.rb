class UsersController < ApplicationController
  before_filter :signed_in_user,
                  only: [:show, :index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]              
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
	  	flash[:success] = "Flash test"
  		redirect_to @user
  	else 
  		render 'new'
  	end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def edit
    @user = current_user
  end

  def update
    # if @user.password == params[:user][:password]
    #   flash[:notice] = "Password matches current"
    # end

    flash[:notice] = params[:user][:password]

    if @user.update_attributes(params[:user])
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


  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
