class BuyItemInfo < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  belongs_to :item

  # バリデーション
  # フォームオブジェクト（Order）に記載
end
