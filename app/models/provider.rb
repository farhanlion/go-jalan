class Provider < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :provider_categories
  has_many :categories, through: :provider_categories
  has_many :provider_tags
  has_many :tags, through: :provider_tags
  has_many :reviews
  has_many :favourites, dependent: :destroy
  # geocoded_by :street_address
  # after_validation :geocode, if: :will_save_change_to_street_address?
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

  def add_rating
    total_reviews = reviews.count
    new_rating = reviews.last.rating
    if total_reviews.zero?
      self.avg_rating = new_rating
    else
      total_rating = self.avg_rating * (total_reviews - 1)
      self.avg_rating = (total_rating + new_rating) / (total_reviews)
    end
    self.save
  end

  def delete_rating(review)
    total_reviews = reviews.count
    avg_rating = self.avg_rating
    rating = review.rating
    if (total_reviews - 1) == 0
      self.avg_rating = 0
    else
      self.avg_rating = (avg_rating - rating) / (total_reviews - 1)
    end
    self.save
  end
end
