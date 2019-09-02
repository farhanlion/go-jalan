class CreateProviderTags < ActiveRecord::Migration[5.2]
  def change
    create_table :provider_tags do |t|
      t.references :provider, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
