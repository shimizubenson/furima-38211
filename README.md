# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
## usersテーブル

| Column             | Type   | Options                 |
| ------------------ | ------ | -----------             |
| nickname           | string | null: false             |
| encrypted_password | string | null: false             |
| email              | string | null: false unique: true|
| last_name          | string | null: false             |
| first_name         | string | null: false             |
| last_name_kana     | string | null: false             |
| first_name_kana    | string | null: false             |
| birthday           | string | null: false             |


### Association

- has_many : items
- has_many : orders

## itemsテーブル

| Column     | Type      | Options                      |
| ---------- | --------- | ---------------------------- |
| seller_name| string    | null: false                  |
| item_name  | string    | null: false                  |
| status     | string    | null: false                  |
| category   | string    | null: false                  |
| postage    | string    | null: false                  |
| region     | string    | null: false                  |
| day_to_ship| string    | null: false                  |
| price      | integer   | null: false                  |
| user       | references|null:false , foreign_key: true|

### Association

- belongs_to :user
- has_one : order

## ordersテーブル

| Column     | Type      | Options                      |
| ---------- | --------- | ---------------------------- |
| buyer_name | string    | null: false                  |
| item       | references|null: false, foreign_key: true|
| user       | references|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item

## order-informationテーブル

| Column       | Type      | Options                      |
| ----------   | --------- | ---------------------------- |
| post_code    | integer   | null: false                  |
| prefectures  | string    | null: false                  |
| city         | string    | null: false                  |
| address      | string    | null: false                  |
| house_number | integer   | null: false                  |
| building_name| string    |                              |
| order        | references|null:false , foreign_key: true|

### Association

- belongs_to :order