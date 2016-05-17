class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :collect_user, only: [:edit, :update]
  
  def index
    @user = user.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user 
    else
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @following_users = @user.following_users
  end
  
  def followers
    @user = User.find(params[:id])
    @follower_users = @user.followed_users
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :country, :profile, :password, :password_confirmation)
    end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def collect_user
    # @user >編集しようとしているUser
    # current_user >いまログインしているUser（私）
    redirect_to root_url if @user != current_user
  end
end