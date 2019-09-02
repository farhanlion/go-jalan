class Provider < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :services
  has_many :categories, through: :provider_category
  has_many :tags, through: :provider_tag
  has_many :reviews
  has_many :provider_favourites
end
