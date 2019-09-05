class Provider < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :provider_categories
  has_many :categories, through: :provider_categories
  has_many :provider_tags
  has_many :tags, through: :provider_tags
  has_many :reviews
  has_many :favourites, dependent: :destroy
  geocoded_by :street_address
  after_validation :geocode, if: :will_save_change_to_street_address?
  has_many :photos
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description, :street_address, :district, :country],
    associated_against: {
      tags: [:name],
      categories: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }
end
