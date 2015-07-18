class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :user_id, uniqueness: true
end
