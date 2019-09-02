class Provider < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :services
  has_many :provider_categories
  has_many :categories, through: :provider_category
  has_many :tags, through: :provider_tag
  has_many :provider_tags
  has_many :reviews
  has_many :provider_favourites
  geocoded_by :street_address
  after_validation :geocode, if: :will_save_change_to_street_address?
end
