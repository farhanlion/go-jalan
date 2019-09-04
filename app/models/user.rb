class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :service_favourites, dependent: :destroy
  has_many :provider_favourites, dependent: :destroy
  mount_uploader :avatar, PhotoUploader
end
