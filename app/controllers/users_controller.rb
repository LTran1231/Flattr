class UsersController < ApplicationController

  def index

  end

  def show
    user = User.find(session[:user_id])
    if user
      render json: user
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  def new
    user = User.new
  end

  def edit

  end

  def create
    user = User.new
    if user.create
      render json: user
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  def update

  end

  def destroy

  end

  private
    def article_params
      params.require(:user).permit(:title, :text)
    end

end
