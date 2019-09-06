class RemoveAvgRatingFromProviders < ActiveRecord::Migration[5.2]
  def change
    remove_column :providers, :avg_rating, :float
  end
end
