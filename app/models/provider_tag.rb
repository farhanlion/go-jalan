class ProviderTag < ApplicationRecord
  belongs_to :provider
  belongs_to :tag
end
