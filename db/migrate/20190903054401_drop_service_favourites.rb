class DropServiceFavourites < ActiveRecord::Migration[5.2]
  def change
    drop_table :service_favourites
  end
end
