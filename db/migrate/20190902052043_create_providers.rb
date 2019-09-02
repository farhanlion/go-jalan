class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :translated_name
      t.text :description
      t.string :price
      t.float :avg_rating
      t.string :street_address
      t.string :district
      t.string :city
      t.string :country
      t.string :open_hours
      t.string :phone_number
      t.string :website
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
