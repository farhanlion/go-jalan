class DropReviewMedia < ActiveRecord::Migration[5.2]
  def change
    drop_table :review_medias
  end
end
