# テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false, unique:true |
| encrypted_password | string | null: false              |
| last_name          | string | null: false              |
| first_name         | string | null: false              |
| last_name_kana     | string | null: false              |
| first_name_kana    | string | null: false              |
| birth_date         | date   | null: false              |

### Association

- has_many :items
- has_many :comments
- has_many :buy_item_infos


## items テーブル

| Column                      | Type       | Options                        |
| --------------------------- | -----------| ------------------------------ |
| user                        | references | null: false, foreign_key: true |
| item_name                   | string     | null: false                    |
| item_info                   | text       | null: false                    |
| item_category_id            | integer    | null: false                    |
| item_sales_status_id        | integer    | null: false                    |
| item_shipping_fee_status_id | integer    | null: false                    |
| item_prefecture_id          | integer    | null: false                    |
| item_scheduled_delivery_id  | integer    | null: false                    |
| item_price                  | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :buy_item_info
- has_many :comments


## comments テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| text        | text       | null: false                    |
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item


## buy_item_infos テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| item              | references | null: false, foreign_key: true |
| user              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
<!-- historiesがaddressを従属させる側 -->
- has_one :shipping_address


## shipping_addresses テーブル

| Column             | Type       | Options                        |
| -----------------  | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| item_prefecture_id | integer    | null: false                    |
| city               | string     | null: false                    |
| addresses          | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| buy_item_info      | references | null: false, foreign_key: true |

### Association
<!-- addressがhistoriesに従属される側 -->
- belongs_to :buy_item_info


