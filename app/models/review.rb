class Review < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  validates :title, presence: true
  validates :rating, presence: true, inclusion: { in: [0, 1, 2, 3, 4, 5] }
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:title, :content],
    associated_against: {
      provider: [:name, :description, :street_address, :district, :country]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
