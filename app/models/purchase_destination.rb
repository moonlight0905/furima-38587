class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :locality, :address, :building_name, :phone, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :locality
    validates :address
    validates :phone,format: {with: /\A\d{10,11}\z/, message: "は10ケタか11ケタの半角数値で入力してください"}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Destination.create(postal_code: postal_code, prefecture_id: prefecture_id, locality: locality, address: address, building_name: building_name, phone: phone, purchase_id: purchase.id)
  end

end