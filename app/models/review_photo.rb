class ReviewPhoto < ApplicationRecord
  mount_uploader :photo_url, PhotoUploader
  belongs_to :review
end
