class RemoveServiceFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :service_id
  end
end
