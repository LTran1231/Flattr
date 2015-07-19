class PhotosController < ApplicationController

  def index
    photos = Photo.all

    if photos
      render json: photos
    else
      render json: { errors: photos.errors.full_messages }
    end
  end

  def show
    photo = Photo.find(params[:id])
    vote = Vote.where(photo_id: params[:id])
    vote_count = vote.count
    like_votes = vote.where(:like => true).count
    rating = (like_votes.to_f / vote_count.to_f) * 100
    if rating >= 90
      rating_saying = "Smokin!!"
    elsif rating >= 80
      rating_saying = "Super Flattering"
    elsif rating >= 70
      rating_saying = "So Flattering"
    elsif rating >= 60
      rating_saying = "Flattering"
    elsif rating >= 50
      rating_saying = "Kind of Flattering"
    else 
      rating_saying = "Not Doing You Justice"
    if photo

      render :json => {
        :photo => photo,
        :vote_count => vote_count,
        :vote => vote,
        :like_votes => like_votes,
        :rating_saying => rating_saying
      }

    else
      render json: { errors: photo.errors.full_messages }
    end
  end

  def new
    photo = Photo.new
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
    photo = Photo.new(article_params)

    if photo
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

    # redirect_to articles_path
  end

  private
    def photo_params
      params.require(:photo).permit(:user_id, :vote_count, :photo_url)
    end
end
