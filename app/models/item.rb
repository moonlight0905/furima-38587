class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days_to_ship

  validates :item_name,         presence: true
  validates :text,              presence: true
  validates :image,             presence: true

  has_one_attached :image

  with_options presence: true, format: { with: /\A[0-9]+\z/} do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999,
                                      message: 'は¥300 ~ ¥9,999,999の半角数値で入力してください' } 
  end

  validates :category_id,       presence: true
  validates :condition_id,      presence: true
  validates :shipping_cost_id,  presence: true
  validates :prefecture_id,     presence: true
  validates :days_to_ship_id,   presence: true

  belongs_to :user

end
