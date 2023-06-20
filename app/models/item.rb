class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days_to_ship

  validates :item_name,         presence: true
  validates :text,              presence: true
  validates :images,            presence: true

  has_many_attached :images

  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                                      message: 'は¥300 ~ ¥9,999,999の半角数値で入力してください' }
  end

  with_options presence: true, format: { without: /\A0\z/ } do
    validates :condition_id, :shipping_cost_id, :prefecture_id, :days_to_ship_id
  end

  belongs_to :user
  has_one    :purchase
  belongs_to :category
end
