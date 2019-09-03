class RemovePhotoUrlFromPhotos < ActiveRecord::Migration[5.2]
  def change
    remove_column :photos, :photo_url, :string
  end
end
