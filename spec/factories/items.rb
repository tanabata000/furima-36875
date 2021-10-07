FactoryBot.define do
  factory :item do
    item_name { '商品名' }
    item_info { '商品の説明' }
    # ActiveHashを使用している場合、階層の番号を入れるだけで良い
    item_category_id { 2 }
    item_sales_status_id { 2 }
    item_shipping_fee_status_id { 2 }
    item_prefecture_id { 2 }
    item_scheduled_delivery_id { 2 }
    item_price { 1000 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/flag.png'), filename: 'flag.png')
    end
  end
end
