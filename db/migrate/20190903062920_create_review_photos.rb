class CreateReviewPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :review_photos do |t|
      t.string :photo_url
      t.references :review, foreign_key: true
    end
  end
end
