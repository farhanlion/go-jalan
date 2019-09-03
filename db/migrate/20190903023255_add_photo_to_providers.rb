class AddPhotoToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :photo, :string
  end
end
