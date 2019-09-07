class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favourites, dependent: :destroy
  mount_uploader :avatar, PhotoUploader

  def favourited_providers
    favourited_providers = []
    self.favourites.each do |fav|
      favourited_providers << fav.provider
    end
    favourited_providers
  end

  def username
   return self.email.match(/(.*)@.*/)[1]
  end
end
