class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :review_likes
  has_many :service_favourites
  has_many :favourites
  mount_uploader :avatar, PhotoUploader

  def favourited_providers
    favourited_providers = []
    self.favourites.each do |fav|
      favourited_providers << fav.provider
    end
    favourited_providers
  end
end
