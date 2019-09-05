class Favourite < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  validates_uniqueness_of :user, scope: :provider
end
