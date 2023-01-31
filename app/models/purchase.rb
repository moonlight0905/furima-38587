class Purchase < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_cost

  belongs_to :user
  belongs_to :item
  has_one    :destination
end
