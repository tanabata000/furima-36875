FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { 'test12345' }
    password_confirmation { password }
    last_name { '苗字' }
    first_name { '名前' }
    last_name_kana { 'ミョウジ' }
    first_name_kana { 'ナマエ' }
    birth_date { '2000-11-11' }
  end
end
