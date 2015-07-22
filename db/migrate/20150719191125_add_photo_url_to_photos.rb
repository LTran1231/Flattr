class AddPhotoUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_url, :text
  end
end
