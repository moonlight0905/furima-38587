# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| family_name        | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name         | string | null: false               |
| first_name_kana    | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| birthday           | string | null: false               |

### Association

- has_many :items
- has_many :purchases
- has_many :destinations

## items テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| item_name | string     | null: false                    |
| text      | text       | null: false                    |
| price     | string     | null: false                    |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :purchase

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :destination  

## destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| postal_code   | string     | null: false                    |
| locality      | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :purchase

