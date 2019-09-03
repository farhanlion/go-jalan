class CreateReviewMedias < ActiveRecord::Migration[5.2]
  def change
    create_table :review_medias do |t|
      t.string :media_url
      t.references :review, foreign_key: true
    end
  end
end
