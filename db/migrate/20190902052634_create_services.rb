class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.float :avg_rating
      t.string :street_address
      t.string :district
      t.string :city
      t.string :country
      t.string :website
      t.string :open_hours
      t.string :phone_number
      t.float :longitude
      t.float :latitude
      t.references :provider, foreign_key: true

      t.timestamps
    end
  end
end
