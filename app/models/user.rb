class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :likes
  has_many :service_favourites
  has_many :provider_favourites
  mount_uploader :avatar, PhotoUploader
end
