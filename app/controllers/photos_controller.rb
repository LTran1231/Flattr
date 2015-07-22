class PhotosController < ApplicationController
  # require_relative '../models/imgur_api'
  # include Imgur

  def index

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
    byebug
    # photo = Photo.new(user_id: params[:user_id], vote_count: params[:vote_count], photo_url: params[:photo_url])
    # base64 = 'params[:photo][:photo_url]'

    # api = Imgur::Client.new(base64)
    # response = api.upload_photo
    # puts response
    # take the response, get the url
    # assign the photo's url to photo(photo_url: )
    # results = {success: 'photo successfully created'}
    if photo.save
      # render json: response
      # render json: results[:success]
      render json: photo
    else
      # render json: response
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
      # params.require(:photo).permit(:user_id, :vote_count, :photo_url)
    end
  end

