class CreateProviderFavourites < ActiveRecord::Migration[5.2]
  def change
    create_table :provider_favourites do |t|
      t.references :provider, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
