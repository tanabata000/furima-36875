class ShippingAddress < ApplicationRecord
  # アソシエーション設定
  belongs_to :buy_item_info
 
  # バリデーション
  validates :postal_code, presence: true
  validates :item_prefecture_id, presence: true
  validates :city, presence: true
  validates :addresses, presence: true
  validates :phone_number, presence: true
  validates :buy_item_info, presence: true
end
