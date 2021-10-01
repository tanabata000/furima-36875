# テーブル設計

## users テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false, unique:true |
| encrypted_password | string | null: false              |
| family_name        | string | null: false              |
| first_name         | string | null: false              |
| family_name_kana   | string | null: false              |
| first_name_kana    | string | null: false              |
| birthday           | date   | null: false              |

### Association

- has_many :items
- has_many :comments
- has_many :histories


## items テーブル

| Column                | Type       | Options                        |
| --------------------- | -----------| ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| item_name             | string     | null: false                    |
| item_description      | text       | null: false                    |
| item_category_id      | integer    | null: false                    |
| item_condition_id     | integer    | null: false                    |
| item_delivery_cost_id | integer    | unique:true                    |
| item_send_area_id     | integer    | null: false                    |
| item_send_schedule_id | integer    | null: false                    |
| item_price            | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :histories
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


## addresses テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| zip_code          | string     | null: false                    |
| prefecture_id     | integer    | null: false                    |
| town              | string     | null: false                    |
| street_num        | string     | null: false                    |
| building_name     | string     |                                |
| phone_num         | integer    | null: false                    |
| history_id        | references | null: false, foreign_key: true |

### Association
<!-- addressがhistoriesに従属される側 -->
- belongs_to :histories


## histories テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| item_id           | integer    | null: false                    |
| user_id           | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
<!-- historiesがaddressを従属させる側 -->
- has_one :address