class RenameProviderFavouritesToFavourites < ActiveRecord::Migration[5.2]
  def change
    rename_table :provider_favourites, :favourites
  end
end
