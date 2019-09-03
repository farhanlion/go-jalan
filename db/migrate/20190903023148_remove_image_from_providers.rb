class RemoveImageFromProviders < ActiveRecord::Migration[5.2]
  def change
    remove_column :providers, :Image, :string
  end
end
