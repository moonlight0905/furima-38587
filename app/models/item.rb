class Item < ApplicationRecord
  validates :item_name,         presence: true

  validates :text,              presence: true

  validates :image,             presence: true
  has_one_attached :image

  with_options presence: true, format: { with: /\A[0-9]+\z/} do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                                      message: 'は¥300 ~ ¥9,999,999の半角数値で入力してください' } 
  end

  validates :category_id,       presence: true, numericality: { other_than: 1 , message: "can't be blank"} 

  validates :condition_id,      presence: true, numericality: { other_than: 1 , message: "can't be blank"} 

  validates :shipping_cost_id,  presence: true, numericality: { other_than: 1 , message: "can't be blank"} 

  validates :prefecture_id,     presence: true, numericality: { other_than: 1 , message: "can't be blank"} 
  
  validates :days_to_ship_id,   presence: true, numericality: { other_than: 1 , message: "can't be blank"}


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_id
  belongs_to :condition_id
  belongs_to :shipping_cost_id
  belongs_to :prefecture_id
  belongs_to :days_to_ship_id

end
