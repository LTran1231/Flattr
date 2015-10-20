class VotesController < ApplicationController

  def create
    photo = Photo.find_by(photo_url: params[:photo])
    vote = Vote.create(user_id: params[:user][:id], photo_id: photo.id, like: params[:like])
  end

end
