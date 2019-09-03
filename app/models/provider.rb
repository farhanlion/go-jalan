class Provider < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :provider_categories
  has_many :categories, through: :provider_category
  has_many :tags, through: :provider_tag
  has_many :provider_tags
  has_many :reviews
  has_many :provider_favourites
  geocoded_by :street_address
  after_validation :geocode, if: :will_save_change_to_street_address?
  has_many :photos
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description, :street_address, :district, :country],
    # associated_against: {
    #   provider_tags: associated_against {
    #     [:],
    #   }
    # },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
