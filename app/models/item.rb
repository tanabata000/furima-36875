class Item < ApplicationRecord
  # アソシエーション設定
  belongs_to :user
  has_one :buy_item_info
  has_many :comments

  # ActiveHashのアソシエーション設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_prefecture
  belongs_to :item_sales_status
  belongs_to :item_scheduled_delivery
  belongs_to :item_shipping_fee_status

  # Active Storageとのアソシエーション設定
  # アソシエーションを組むと同時にでカラム名を決定する。カラム名＝image
  has_one_attached :image
  
   # 正規表現
    # 全て半角数字
    hankaku_num = /\A[0-9]+\z/
  # バリデーション
  # validates :user_id, presence: true
  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_info, presence: true
  validates :item_category_id, presence: true
  validates :item_sales_status_id, presence: true
  validates :item_shipping_fee_status_id, presence: true
  validates :item_prefecture_id, presence: true
  validates :item_scheduled_delivery_id, presence: true
  # format:は文字列にしか適用しないためnumericality:を使用
  validates :item_price, presence: true, numericality: { with: hankaku_num }
  # validates_inclusion_of：値が配列・範囲に含まれているかを確認する
  validates_inclusion_of :item_price, in: 300..9999999 
  
  # ActiveHashのバリデーション
  # ジャンルの選択が「--」の時は保存できないようにする
  # 「can't be blank」というエラーメッセージがユーザーに表示されるよう設定
  validates :item_category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_sales_status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_scheduled_delivery_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_shipping_fee_status_id, numericality: { other_than: 1 , message: "can't be blank"}
end