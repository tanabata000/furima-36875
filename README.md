# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | unique:true |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birth_year         | string | null: false |
| birth_month        | string | null: false |
| birth_day          | string | null: false |

### Association

- has_many :items
- has_many :comments

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | -----------| ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item_name          | text       | null: false                    |
| item_description   | text       | null: false                    |
| item_category      | string     | null: false                    |
| item_condition     | string     | null: false                    |
| item_delivery_cost | string     | unique:true                    |
| item_send_area     | string     | null: false                    |
| item_send_schedule | string     | null: false                    |
| item_price         | string     | null: false                    |


### Association

- belongs_to :user
- has_many :comments

## comments テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| text        | text       | null: false                    |
| item_id     | references | null: false, foreign_key: true |
| user_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item