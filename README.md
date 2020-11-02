# README
# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| password           | string | null: false |

### Association
- has_many :recipes
- has_many :diaries

### recipes テーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| user               | references  | null: false, foreign_key: true |
| name               | string      | null: false                    |
| genre_id           | integer     | null: false                    |
| food               | text        | null: false                    |
| seasoning          | text        | null: false                    |
| procedure          | text        | null: false                    |

### Association
- belongs_to  :user

### diaries テーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| user               | references  | null: false, foreign_key: true |
| time               | datetime    | null: false                    |
| title              | string      | null: false                    |
| impression         | text        | null: false                    |

### Association
- belongs_to  :user