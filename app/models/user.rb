class User < ActiveRecord::Base

  validates :provider, presence: :true
  validates :uid, presence: :true
  validates :name, presence: :true

  validates_uniqueness_of :uid, scope: :provider

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]

      if user.provider != "twitter"
        user.name = auth["info"]["name"]
      else
        user.name = auth["info"]["nickname"]
      end
    end
  end
end
