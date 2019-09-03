class RemoveImagesFromProviders < ActiveRecord::Migration[5.2]
  def change
    remove_column :providers, :images, :string
  end
end
