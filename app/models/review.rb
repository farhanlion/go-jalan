class Review < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  has_many :tags, through: :provider
  has_many :categories, through: :provider
  validates :title, presence: true
  validates :rating, presence: true, inclusion: { in: [0, 1, 2, 3, 4, 5] }
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:title, :content],
    associated_against: {
      provider: [:name, :description, :street_address, :district, :country],
      tags: [:name],
      categories: [:name]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  has_many :review_photos
  has_many :review_likes
end
