class UsersController < ApplicationController
  def facebook
    user = params[:user]
    provider = "facebook"
    @user = User.create_from_provider(user, provider)
    session[:user_id] = @user.id
    photos = @user.photos
    render json: { user: current_user, photos: photos }
  end

  def google
    user = params[:user]
    provider = "google"
    @user = User.create_from_provider(user, provider)
    session[:user_id] = @user.id
    photos = @user.photos
    render json: { user: current_user, photos: photos }
  end

  def index
    users = User.all
    if users
      render json: users
    else
      render json: { errors: users.errors.full_messages }
    end
  end

  def show
    user = User.find(params[:id])
    if user
      render json: user
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  def new
    user = User.new
  end

  def create
    user = User.new
    if user.create
      render json: user
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  private
    def article_params
      params.require(:user).permit(:title, :text)
    end

end
