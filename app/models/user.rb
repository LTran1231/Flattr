class User < ActiveRecord::Base
  has_many :photos
  validates :uid, presence: true

  # validates :body_type, presence: true
  # validates :dob, presence: true
  # validates :first_name, presence: true
  # validates :gender, presence: true
  # validates :last_name, presence: true
  # validates :password, presence: true
  # validates :username, presence: true

  # validates :username, uniqueness: true
  # validates :email, uniqueness: true
  def self.create_from_provider(user)
    uid = "#{user[:uid]}"
    first_name = "#{user[:facebook][:cachedUserProfile][:first_name]}"
    last_name = "#{user[:facebook][:cachedUserProfile][:last_name]}"
    age = "#{user[:facebook][:cachedUserProfile][:age_range][:min]}"
    gender = "#{user[:facebook][:cachedUserProfile][:gender]}" 
    avatar = "#{user[:facebook][:cachedUserProfile][:picture][:data][:url]}" 
    existing_user = self.where(uid: uid).first
    if existing_user
      # existing_user.udpate(
      #   first_name: first_name,
      #   last_name: last_name,
      #   age: age,
      #   gender: gender,
      #   avatar: avatar
      #   )
      return existing_user
    else
      self.create(
        uid: uid,
        first_name: first_name,
        last_name: last_name,
        age: age,
        gender: gender,
        avatar: avatar
        )
    end
  end
end



