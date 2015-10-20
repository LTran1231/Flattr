class Vote < ActiveRecord::Base
	belongs_to :photo
	belongs_to :user

	scope :liked,     ->{ where(like: true) }
	scope :not_liked, ->{ where(like: false) }
end
