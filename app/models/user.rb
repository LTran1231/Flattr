class User < ActiveRecord::Base
  has_many :photos

  validates :body_type, presence: true
  validates :dob, presence: true
  validates :first_name, presence: true
  validates :gender, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :username, presence: true

  validates :username, uniqueness: true
  validates :email, uniqueness: true

end
