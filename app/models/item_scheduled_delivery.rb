class ItemScheduledDelivery < ActiveHash::Base
  self.data = [
    # '--'はバリデーションにより保存されない設定する
    { id: 1, name: '--' },
    { id: 2, name: '1~3日で発送' },
    { id: 3, name: '2~3日で発送' },
    { id: 4, name: '4~7日で発送' }
  ]
  # メニュー管理モデルのアソシエーションを設定
  include ActiveHash::Associations
  has_many :items
end
