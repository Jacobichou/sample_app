class UsersController < ApplicationController

  before_filter :signed_in_user,  only: [:index, :edit, :update]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only:  :destroy
  before_filter :already_signed_in_user, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(params[:user])

  	if @user.save
  		# Handle successful save.
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    # @user = User.find(params[:id])  --commented out due to helper
  end

  def update
    # @user = User.find(params[:id])  --commented out due to helper

    if @user.update_attributes(params[:user])
      # handle successful update
      flash[:success] = "Profile updated!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    unless User.find(params[:id]).admin?
      User.find(params[:id]).destroy
      flash[:success] = "User removed."
      redirect_to users_url
    else
      redirect_to users_url
    end
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def already_signed_in_user
    redirect_to root_path unless !signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
