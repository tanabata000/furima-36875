class Order
  # buy_item_info ＆ shipping_addressのFormオブジェクト

  # DonationAddressクラスにActiveModel::Modelをinclude
  include ActiveModel::Model
  # 保存したいカラム名を属性値として扱えるようにする
  # buy_item_info ＆ shipping_addressに保存したいカラム名を、すべて指定
  attr_accessor :user_id, :item_id, :postal_code, :item_prefecture_id, :city, :addresses, :building, :phone_number, :buy_item_info, :item_price, :token
  
  # buy_item_infoのバリデーション
  validates :item_id, presence: true
  validates :user_id, presence: true

  # shipping_addressのバリデーション
  validates :postal_code, presence: true
  validates :item_prefecture_id, presence: true
  validates :city, presence: true
  validates :addresses, presence: true
  validates :phone_number, presence: true
  # データベース上に表示はされないがトークンにバリデーションをかけることができる
  validates :token, presence: true

  def save
    # 寄付情報を保存し、変数donationに代入する
    buy_item_info = BuyItemInfo.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    ShippingAddress.create(postal_code: postal_code, item_prefecture_id: item_prefecture_id, city: city, addresses: addresses, building: building, phone_number: phone_number, buy_item_info_id: buy_item_info.id)
  end
end