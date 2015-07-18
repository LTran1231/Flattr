class User < ActiveRecord::Base
  has_many :photos
  has_many :votes
  validates :uid, presence: true


  # validates :body_type, allow_blank: true
  # validates :age, allow_blank: true
  # validates :first_name, allow_blank: true
  # validates :gender, allow_blank: true
  # validates :last_name, allow_blank: true


  def self.create_from_provider(user, provider)
    if provider == "facebook"
      first_name = "first_name"
      last_name = "last_name"
      age = "#{user[provider][:cachedUserProfile][:age_range][:min]}"
      avatar = "#{user[provider][:cachedUserProfile][:picture][:data][:url]}"
    elsif provider == "google"
      first_name = "given_name"
      last_name = "family_name"
      avatar = "#{user[provider][:cachedUserProfile][:picture]}"
    end
    uid = "#{user[:uid]}"
    first_name = "#{user[provider][:cachedUserProfile][first_name]}"
    last_name = "#{user[provider][:cachedUserProfile][last_name]}"
    gender = "#{user[provider][:cachedUserProfile][:gender]}"
    existing_user = User.find_by(uid: uid)
    if existing_user
      # self.udpate!(
      #   first_name: first_name,
      #   last_name: last_name,
      #   age: age,
      #   gender: gender,
      #   avatar: avatar,
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



