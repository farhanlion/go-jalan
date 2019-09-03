class Service < ApplicationRecord
  belongs_to :provider
  validates :name, presence: true, uniqueness: true
  has_many :reviews
  has_many :service_favourites
  # has_many :service_photos
end
