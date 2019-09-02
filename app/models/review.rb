class Review < ApplicationRecord
  belongs_to :provider
  belongs_to :service, optional: true
  belongs_to :user
  validates :title, presence: true
  validates :rating, presence: true, inclusion: { in: [0, 1, 2, 3, 4, 5] }
end
