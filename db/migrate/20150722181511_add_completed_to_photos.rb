class AddCompletedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :completed, :boolean, default: false
    add_column :photos, :expired_date, :datetime
  end
end
