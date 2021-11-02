class Order
  # buy_item_info ＆ shipping_addressのFormオブジェクト

  # DonationAddressクラスにActiveModel::Modelをinclude
  include ActiveModel::Model
  # 保存したいカラム名を属性値として扱えるようにする
  # buy_item_info ＆ shipping_addressに保存したいカラム名を、すべて指定
  attr_accessor :user_id, :item_id, :postal_code, :item_prefecture_id, :city, :addresses, :building, :phone_number,
                :buy_item_info, :item_price, :token

  # 正規表現
  # 全て数字（3桁ハイフン4桁）
  postal_code_num = /\A\d{3}-\d{4}\z/
  # 全て数字（10〜11桁）
  phone_number_num  = /\A\d{10,11}\z/

  # バリデーション設定
  # buy_item_infoのバリデーション
  validates :item_id, presence: true
  validates :user_id, presence: true
  # shipping_addressのバリデーション
  validates :postal_code, presence: true, format: { with: postal_code_num }
  validates :item_prefecture_id, presence: true
  validates :item_prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :city, presence: true
  validates :addresses, presence: true
  validates :phone_number, presence: true
  validates :phone_number, format: { with: phone_number_num }
  # データベース上に表示はされないがトークンにバリデーションをかけることができる
  validates :token, presence: true

  def save
    # 寄付情報を保存し、変数buy_item_infoに代入する
    buy_item_info = BuyItemInfo.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # buy_item_info_idには、変数buy_item_infoのidと指定する
    ShippingAddress.create(postal_code: postal_code, item_prefecture_id: item_prefecture_id, city: city, addresses: addresses,
                           building: building, phone_number: phone_number, buy_item_info_id: buy_item_info.id)
  end
end
