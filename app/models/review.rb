class Review < ApplicationRecord
  extend OrderAsSpecified
  belongs_to :provider
  belongs_to :user
  has_many :tags, through: :provider
  has_many :categories, through: :provider
  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:content],
    associated_against: {
      provider: [:name, :description, :street_address, :district, :country],
      tags: [:name],
      categories: [:name],
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  has_many :review_photos, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :best, -> { where.not(review_photo: []) }

  def next
    self.class.best.where("id > ?", self.id).first
  end
end
