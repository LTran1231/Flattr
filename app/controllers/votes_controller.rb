class VotesController < ApplicationController

  def create
    p "*" * 80
    p params[:photo]
    # @vote = Vote.new(user_id: params[:user], )
    # User = User.find_by(email: params[:user][:email])

    photo = Photo.find_by(photo_url: params[:photo])
    p photo
    vote = Vote.new(user_id: params[:user][:id], photo_id: photo.id, like: params[:like])
    if vote.save
      p "*" * 10
      p "vote saved"
      p "*" * 10
    else
      p "*" * 10
      p "vote ERROR NOT SAVED"
      p "*" * 10
    end
  end

  def new
  end
end
