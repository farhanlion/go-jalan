class AddImagesToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :images, :string, array: true, default: []
  end
end
