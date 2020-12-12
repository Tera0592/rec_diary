# README

# アプリ名

Recipe Diary

# 概要

本アプリでは誰でも簡単に料理レシピを検索、閲覧ができます。またユーザー管理機能を実装しており、自分で考案したオリジナルレシピを投稿できます。レシピ投稿者はいつでも編集、削除が可能で、マイページからも閲覧が可能となってます。
また自分で料理を作った時に、完成写真や反省点などを自分専用の日記に記録ができます。これから一人暮らしを始める方や、料理がもっと上手になりたいという人にオススメです！

# 本番環境

https://recipe-diary-29368.herokuapp.com/

ログイン情報(テスト用)

- レシピ、日記投稿者
  - メールアドレス: sample001@yahoo.co.jp
  - パスワード: sample001

- 閲覧者
  - メールアドレス: sample003@yahoo.co.jp
  - パスワード: sample003

# 制作背景(意図)

このアプリを作った理由は、大学時代の経験によるものです。というのも大学生の時に、お金節約のためにお家でよく自炊を行っていました。
そしてどうせ作るなら美味しい料理を作れるようになりたいと思い、クックパッドやクラシルなどのレシピ閲覧サイトをよく利用していました。
しかし、レシピ通りに作ろうとしてもなかなかうまくいかないことの方が多かったです。なぜ上手くいかなかったのだろうと、考えた時に、毎回同じような所で
ミスをしてるなと思いました。つまり、前回同じ料理を作った時の失敗、反省点を意識せずに作っているから一向に料理が向上しないと思いました。
とはいえ、日記アプリ等にその日の反省点や次回への目標を綴った所で、料理を作る前に見なければ意味がありません。その為、レシピも閲覧ができ、過去の自分の料理記録も
空き時間に閲覧が同時にできる機能を兼ね備えたアプリがあればいいなと思い作成しました。

# DEMO

## トップページ (料理レシピ一覧表示画面)

## ユーザー管理機能

### 新規登録画面

### ログイン画面

### マイページ画面

## 料理レシピ関連機能

### 投稿画面

### 検索画面

### 詳細表示・編集・削除画面

## 日記関連機能

### 表示画面 (詳細表示・編集・削除)

### 作成画面



# 工夫したポイント

なるべく、初めてサイトに訪れたユーザーでも使用しやすいようにシンプルな内容にするように努めました。例えば、ログインしてユーザー名の所にマウスを移動させるとメニューが開いたり、ユーザ登録画面で入力内容に不備があった場合に日本語でエラーメッセージが表示されるようにした所です。

# 使用技術(開発環境)

## バックエンド

Ruby,Ruby on Rails

## フロントエンド

HTML,CSS,JavaScript,jQuery

## データベース

MySQL SequelPro

## インフラ

AWS(S3)

## Webサーバ (本番環境)

nginx

## アプリケーションサーバ (本番環境)

unicorn

## ソース管理

GitHub,GitHubDesktop

## テスト

RSpec

## エディタ

VSCode

# 課題や今後実装したい機能

## 課題

トップページをはじめとした、ページ一つ一つの見た目がシンプルでわかりやすいようにしましたが、逆にありきたりすぎて華やかさが、足りないように感じました。またユーザーが直感的に操作しやすく、記述するコードも比較的短いjQueryを用いた機能実装が少ないことも今後の課題です。

## 実装したい機能

- レシピのお気に入り登録機能
  <br>内容: ログインしたユーザーは投稿されているレシピをお気に入り登録をすることができ、お気に入り数をカウントする。またマイページからお気に入り登録したレシピを確認ができる。
  <br>理由: お気に入りする側のユーザーはレシピ検索の手間が省けて、お気に入りされる側は、カウント数によってモチベーションが高まり新たなレシピ投稿につながると考えている為。
  <br>使用技術: jQueryを用いた非同期通信で実装予定。

- レシピを閲覧しながら、日記も閲覧可能な機能
  <br>内容: ログインしているユーザーは、料理レシピを閲覧しながら、過去の料理記録を遡り、確認することができる
  <br>理由: レシピを閲覧しながら、自分が過去に記録した料理記録を見ることによって、過去に犯したい失敗を繰り返さなように気を配ることができると考えているから。
  <br>使用技術: jQueryを用いた非同期通信で実装予定。
  
# DB設計

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