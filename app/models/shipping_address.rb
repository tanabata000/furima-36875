class ShippingAddress < ApplicationRecord
  # アソシエーション設定
  belongs_to :buy_item_info

  # バリデーション
  # フォームオブジェクト（Order）に記載
end
