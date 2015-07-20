class PhotosController < ApplicationController
  # require_relative '../models/imgur_api'
  # include Imgur

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
    votes = Vote.where(photo_id: params[:id])
    vote_count = votes.count
    like_votes = votes.where(:like => true).count
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
    end

    male = 0
    female = 0
    under_twenty = 0
    twenty_one_forty = 0
    forty_one_sixty = 0
    sixty_eighty = 0
    thin = 0
    medium = 0
    large = 0
    female_under_20 = 0
    male_under_20 = 0
    female_21_40 = 0
    male_21_40 = 0
    female_41_60 = 0
    male_41_60 = 0
    female_61_80 = 0
    male_61_80 = 0

    votes.each do |vote|
      gender = User.find(vote.user_id).gender
      age = User.find(vote.user_id).age
      body_type = User.find(vote.user_id).body_type
      # gender search
      if gender == "male"
        male += 1
      else
        female += 1
      end
      # age search
      if age <= 20
        under_twenty += 1
      elsif age <= 40
        twenty_one_forty += 1
      elsif age <= 60
        forty_one_sixty += 1
      else
        sixty_eighty +=1
      end
      # bodytype search
      if body_type == "thin"
        thin += 1
      elsif body_type == "medium"
        medium += 1
      else
        large +=1
      end
      # age and gender search
      if age <= 20 && gender == "female"
        female_under_20 += 1
      elsif age <= 20 && gender == "male"
        male_under_20 += 1
      elsif age <= 40 && gender == "female"
        female_21_40 += 1
      elsif age <= 40 && gender == "male"
        male_21_40 += 1
      elsif age <= 60 && gender == "male"
        female_41_60 += 1
      elsif age <= 60  && gender == "female"
        male_41_60 += 1
      elsif age > 60  && gender == "female"
        female_61_80 += 1
      else
        male_61_80 += 1
      end




    end

    female_percentage = ((female.to_f / vote_count.to_f) * 100).floor
    male_percentage = ((male.to_f / vote_count.to_f) * 100).floor
    under_twenty_percentage = ((under_twenty.to_f / vote_count.to_f) * 100).floor
    twenty_one_forty_percentage = ((twenty_one_forty.to_f / vote_count.to_f) * 100).floor
    forty_one_sixty_percentage = ((forty_one_sixty.to_f / vote_count.to_f) * 100).floor
    sixty_eighty_percentage = ((sixty_eighty.to_f / vote_count.to_f) * 100).floor
    thin_percentage = ((thin.to_f / vote_count.to_f) * 100).floor
    medium_percentage = ((medium.to_f / vote_count.to_f) * 100).floor
    large_percentage = ((large.to_f / vote_count.to_f) * 100).floor
    female_under_20_percentage = ((female_under_20.to_f / vote_count.to_f) * 100).floor
    male_under_20_percentage = ((male_under_20.to_f / vote_count.to_f) * 100).floor
    female_21_40_percentage = ((female_21_40.to_f / vote_count.to_f) * 100).floor
    male_21_40_percentage = ((male_21_40.to_f / vote_count.to_f) * 100).floor
    female_41_60_percentage = ((female_41_60.to_f / vote_count.to_f) * 100).floor
    male_41_60_percentage = ((male_41_60.to_f / vote_count.to_f) * 100).floor
    female_61_80_percentage = ((female_61_80_percentage.to_f / vote_count.to_f) * 100).floor
    male_61_80_percentage = ((male_61_80.to_f / vote_count.to_f) * 100).floor


    if photo
      render :json => {
        :photo => photo,
        :vote_count => vote_count,
        :vote => votes,
        :like_votes => like_votes,
        :rating_saying => rating_saying,
        :female_percentage => female_percentage,
        :male_percentage => male_percentage,
        :under_twenty_percentage => under_twenty,
        :twenty_one_forty_percentage => twenty_one_forty_percentage,
        :forty_one_sixty_percentage => forty_one_sixty_percentage,
        :sixty_eighty_percentage => sixty_eighty_percentage,
        :thin_percentage => thin_percentage,
        :medium_percentage => medium_percentage,
        :large_percentage =>  large_percentage,
        :female_under_20_percentage => female_under_20_percentage,
        :male_under_20_percentage => male_under_20_percentage,
        :female_21_40_percentage => female_21_40_percentage,
        :male_21_40_percentage => male_21_40_percentage,
        :female_41_60_percentage => female_41_60_percentage,
        :male_41_60_percentage => male_41_60_percentage,
        :female_61_80_percentage => female_61_80_percentage,
        :male_61_80_percentage => male_61_80_percentage,
        :female_vote => female,
        :male_vote => male,
        :under_twenty_vote => under_twenty,
        :twenty_one_forty_vote => twenty_one_forty,
        :forty_one_sixty_vote => forty_one_sixty,
        :sixty_eighty_vote => sixty_eighty,
        :thin_vote => thin,
        :medium_vote => medium,
        :large_vote => large,
        :female_under_20_vote => female_under_20,
        :male_under_20_vote => male_under_20,
        :female_21_40_vote => female_21_40,
        :male_21_40_vote => male_21_40,
        :female_41_60_vote => female_41_60,
        :male_41_60_vote => male_41_60,
        :female_61_80_vote => female_61_80,
        :male_61_80_vote => male_61_80

      }

    else
      render json: { errors: photo.errors.full_messages }
    end

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
    # photo = Photo.new(user_id: params[:user_id], vote_count: params[:vote_count], photo_url: params[:photo_url])
    base64 = 'params[:photo][:photo_url]'
    api = Imgur::Client.new(base64)
    response = api.upload_photo

    # take the response, get the url
    # assign the photo's url to photo(photo_url: )
    # results = {success: 'photo successfully created'}
    if photo.save
      render json: response
      # render json: results[:success]
      # render json: photo
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

