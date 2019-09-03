class RemovePhotoFromProviders < ActiveRecord::Migration[5.2]
  def change
    remove_column :providers, :photo, :string
  end
end
