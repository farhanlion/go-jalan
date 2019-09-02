class CreateServiceFavourites < ActiveRecord::Migration[5.2]
  def change
    create_table :service_favourites do |t|
      t.references :service, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
