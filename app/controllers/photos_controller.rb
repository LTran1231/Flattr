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

    votes.each do |vote|
      gender = User.find(vote.user_id).gender 
      age = User.find(vote.user_id).age
      
      if gender == "male" 
        male += 1
      else 
        female += 1
      end
      
      if age <= 20
        under_twenty += 1
      elsif age <= 40
        twenty_one_forty += 1
      elsif age <= 60
        forty_one_sixty += 1
      else
        sixty_eighty +=1 
      end


    end
    female_vote = ((female.to_f / vote_count.to_f) * 100).floor
    male_vote = ((male.to_f / vote_count.to_f) * 100).floor
    under_twenty_vote = ((under_twenty.to_f / vote_count.to_f) * 100).floor
    twenty_one_forty_vote = ((twenty_one_forty.to_f / vote_count.to_f) * 100).floor
    forty_one_sixty_vote = ((forty_one_sixty.to_f / vote_count.to_f) * 100).floor
    sixty_eighty_vote = ((sixty_eighty.to_f / vote_count.to_f) * 100).floor


    if photo
      render :json => {
        :photo => photo,
        :vote_count => vote_count,
        :vote => votes,
        :like_votes => like_votes,
        :rating_saying => rating_saying,
        :female_vote => female_vote,
        :male_vote => male_vote,
        :under_twenty_vote => under_twenty,
        :twenty_one_forty_vote => twenty_one_forty,
        :forty_one_sixty_vote => forty_one_sixty,
        :sixty_eighty_vote => sixty_eighty
                  
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
