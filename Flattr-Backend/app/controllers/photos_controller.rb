class PhotosController < ApplicationController

  def user_photos
    user = User.find(params[:id])
    photo = Photo.where.not(id: Vote.where(user_id: user.id).pluck(:photo_id)).where.not(user_id: user.id)[0]
    if photo
      render json: {photo: photo.photo_url}
    else
      render json: { errors: photo.errors.full_messages }
    end
  end

  def index
    photos = Photo.all
    render json: photos
  end

  def show
    photo = Photo.find(params[:id])
    render :json => PhotoRatingCalculator.call(photo)
  end


  def new
    photo = Photo.new
    if photo
      render json: photo
    else
      render json: photo
    end
  end

  def edit
    photo = Photo.find(params[:id])
    if photo
      render json: photo
    else
      render json: { errors: photo.errors.full_messages }
    end
  end

  def create
    photo = Photo.new(photo_params)
    if photo.save
      render json: photo
    else
      render json: { errors: photo.errors.full_messages }
    end
  end

  def update
    photo = Photo.find(params[:id])
    if photo.update(photo_params)
      render json: photos
    else
      render json: { errors: photos.errors.full_messages }
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
  end

  private

  def photo_params
    params.require(:photo).permit(:user_id, :vote_count, :photo_url)
  end
  
end

