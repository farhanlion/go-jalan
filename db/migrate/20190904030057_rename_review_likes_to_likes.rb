class RenameReviewLikesToLikes < ActiveRecord::Migration[5.2]
  def change
    rename_table :review_likes, :likes
  end
end
