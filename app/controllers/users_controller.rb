class UsersController < ApplicationController

  # controller-status: satisfied
  def index
    users = User.all
    if users
      render json: users
    else
      render json: { errors: users.errors.full_messages }
    end
  end

  # controller-status: satisfied
  def show
    user = User.find(session[:user_id])
    if user
      render json: user
    else
      render json: { errors: user.errors.full_messages }
    end
  end

 # controller-status: satisfied
  def new
    user = User.new
  end

  # controller-status: satisfied
  def edit

  end

  # controller-status: satisfied
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

  # controller-status: satisfied
  def destroy
    user = User.find(session[:user_id])
    user.destroy
    message = "We hope you comeback"
    render json: message
  end

  private
    def article_params
      params.require(:user).permit(:usename, :first_name, :last_name, :body_type, :gender, :dob, :password, :email)
    end

end

