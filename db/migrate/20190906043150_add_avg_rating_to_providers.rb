class AddAvgRatingToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :avg_rating, :float, default: 0, null: false
  end
end
