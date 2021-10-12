FactoryBot.define do
  factory :order do
    postal_code { '123-4567' }
    item_prefecture_id { 2 }
    city { '札幌市中央区' }
    addresses { '1-1' }
    phone_number { 1_111_111_111 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
