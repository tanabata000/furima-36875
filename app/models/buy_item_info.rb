class BuyItemInfo < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  belongs_to :item
 
  # バリデーション
  # validates :item, presence: true
  # validates :user, presence: true
end
