class AddImageToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :Image, :string
  end
end
