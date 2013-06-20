class UsersController < ApplicationController

  before_filter :signed_in_user,  only: [:index, :edit, :update]
  before_filter :correct_user,    only: [:edit, :update]

  def index
    @users = User.all
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

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
