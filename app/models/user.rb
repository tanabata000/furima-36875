class User < ApplicationRecord
  # アソシエーション設定
  has_many :items
  has_many :comments
  has_many :buy_item_infos

  # deviseのデフォルトのモジュール（詳しくはdeviseモジュール概要で調べる）
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
    # 正規表現
    # パスワードは英数字混合
    # 先頭文字列とマッチ[0-9,a-z,A-Z]+末尾[0-9,a-z,A-Z]となっている。大小文字区別なし
    password_spell_valid = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
    # 全角（ひらがな、カタカナ、漢字）
    # 先頭から全てひらがな、カタカナ、漢字（々を含む）、ーで構成。「々ー」がないと「佐々木」や「メアリー」などが保存不可
    zenkaku_valid = /\A[ぁ-んァ-ン一-龥々ー]/
    # 全角カタカナ
    # 先頭から末尾まで全てカタカナで構成
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