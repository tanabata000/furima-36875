class User < ApplicationRecord
  # アソシエーション設定
  has_many :items
  has_many :comments
  has_many :buy_item_infos

  # deviseのデフォルトのモジュール（詳しくはdeviseモジュール概要で調べる）
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
    # 正規表現
    # パスワードは英数字混合（最低1文字は必要）
    password_spell_valid = /\A[a-zA-Z0-9]+\z/
    # 全角（ひらがな、カタカナ、漢字）
    zenkaku_valid = /\A[ぁ-んァ-ン一-龥]/
    # 全角カタカナ
    kana_valid = /\A[ァ-ヶー－]+\z/

    # バリデーション
    validates :password, format: { with: password_spell_valid }
    validates :nickname, presence: true
    validates :last_name, presence: true, format: { with: zenkaku_valid }
    validates :first_name, presence: true, format: { with: zenkaku_valid }
    validates :last_name_kana, presence: true, format: { with: kana_valid }
    validates :first_name_kana, presence: true, format: { with: kana_valid }
    validates :birth_date, presence: true
  
  
end