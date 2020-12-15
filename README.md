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
しかし、レシピ通りに作ろうとしてもなかなかうまくいかないことの方が多かったです。なぜ上手くいかなかったか原因を考えた際、毎回同じようなところで
ミスをしていることに気づきました。つまり、前回同じ料理を作った時の失敗、反省点を意識せずに作っているから一向に料理が向上しないと思いました。
とはいえ、日記アプリ等にその日の反省点や次回への目標を綴った所で、料理を作る前に見なければ意味がありません。その為、レシピも閲覧ができ、過去の自分の料理記録も
空き時間に閲覧が同時にできる機能を兼ね備えたアプリがあればいいなと思い作成しました。

# DEMO

## トップページ (料理レシピ一覧表示画面)

<img width="1417" alt="top-page-1" src="https://user-images.githubusercontent.com/69949838/102034380-392be700-3e01-11eb-9386-c330d57a3dd4.png">

<img width="1436" alt="top-page-2" src="https://user-images.githubusercontent.com/69949838/102034441-58c30f80-3e01-11eb-9f3e-6b5d336320a2.png">

このアプリのトップページです。アプリへのログインの有無に関わらず、自分や他のユーザーが投稿した料理レシピの一覧が見れます。また上部の検索欄からは料理レシピを検索が可能となっています。

## ユーザー関連

### 新規登録画面

#### No1
<img width="1440" alt="sign-in" src="https://user-images.githubusercontent.com/69949838/102034888-73e24f00-3e02-11eb-82b9-96357461453c.png">

ユーザーの新規登録画面です。こちらから、ニックネーム、メールアドレス、パスワードを設定してユーザー登録ができます。

#### No2
<img width="1440" alt="sign-in-error" src="https://user-images.githubusercontent.com/69949838/102034918-88264c00-3e02-11eb-8ad8-4da18f22c33b.png">

ユーザー登録内容に不備があった場合は、日本語のエラーメッセージがでます。

### ログイン画面

#### No1
<img width="1432" alt="log-in" src="https://user-images.githubusercontent.com/69949838/102034959-9ffdd000-3e02-11eb-8183-14b4350b0d8c.png">

登録した際のユーザーのメールアドレス、パスワードを入力して、ログインします。

### マイページ画面

#### No1
<img width="1429" alt="top-my-page" src="https://user-images.githubusercontent.com/69949838/102049577-79509100-3e24-11eb-83ca-0f257a45c581.png">

#### No2
<img width="1440" alt="my-page-1" src="https://user-images.githubusercontent.com/69949838/102035133-05ea5780-3e03-11eb-9927-626434a6abe0.png">

<img width="1440" alt="my-page-2" src="https://user-images.githubusercontent.com/69949838/102049597-87061680-3e24-11eb-9052-743f137f685b.png">

ログインしてる場合、トップページのニックネームが表示されている部分にマウスを動かすとメニューが下に開き、「マイページ」を押すと遷移します。
登録しているユーザーのニックネーム、メールアドレスをこのマイページで確認ができます。必要なら、ニックネーム、メールアドレスを編集もできます。さらにユーザーが料理レシピを投稿をしてる場合、マイページにて確認もできます。

## 料理レシピ関連

### 投稿画面

#### No1
<img width="1435" alt="top-post-recipe" src="https://user-images.githubusercontent.com/69949838/102050007-5377bc00-3e25-11eb-9e51-230e4566cd02.png">

#### No2
<img width="1440" alt="recipe-post-1" src="https://user-images.githubusercontent.com/69949838/102035366-890bad80-3e03-11eb-8ac9-19038e72e770.png">

<img width="1440" alt="recipe-post-2" src="https://user-images.githubusercontent.com/69949838/102035392-94f76f80-3e03-11eb-86b3-0a3491ad9569.png">

ログインしてる場合、トップページのニックネームが表示されている部分にマウスを動かすとメニューが下に開き、「レシピを投稿する」を押すと遷移します。
登録したい料理レシピの写真、ジャンル、材料、調味料、作り方を入力すると、投稿ができます。また入力内容に不備があった場合は、ユーザー新規登録画面同様、日本語のエラーメッセージが表示されます。


### 詳細表示・編集・削除画面

#### No1
<img width="1440" alt="recipe-show-1" src="https://user-images.githubusercontent.com/69949838/102035417-a5a7e580-3e03-11eb-975d-0e808c458b5e.png">

<img width="1440" alt="recipe-show-2" src="https://user-images.githubusercontent.com/69949838/102035433-afc9e400-3e03-11eb-8c58-587387c0bc97.png">

トップページのレシピ一覧から料理名をクリックすると、レシピ詳細画面に遷移します。レシピの投稿者が詳細画面に遷移した場合、同ページ内にて編集・削除が可能となっています。
ユーザーがログインしていない、もしくは他ユーザーが投稿したレシピの詳細画面に遷移した場合、「レシピの編集」、「レシピの削除」は表示されない仕様となっています。

## 料理日記関連

### 一覧表示画面

#### No1
<img width="1423" alt="top-index-diary" src="https://user-images.githubusercontent.com/69949838/102051266-a5214600-3e27-11eb-88a6-2b2be60ef7da.png">

#### No2
<img width="1440" alt="diary-index" src="https://user-images.githubusercontent.com/69949838/102036151-72feec80-3e05-11eb-8056-73ee8891d104.png">

ログインしてる場合、トップページのニックネームが表示されている部分にマウスを動かすとメニューが下に開き、「日記一覧」を押すと遷移します。
ユーザーが日記投稿している場合、一覧画面に日記の日付、タイトルが表示されます。また写真の右横の「▼」部分に、マウスを動かすとメニューが下に開き、「詳細」、「編集」、「削除」が表示される仕様となっています。ユーザーがログインしていない、もしくは他ユーザーの日記は閲覧することは不可能となっていて、あくまで個人用の日記として活用ができます。

### 詳細表示・編集・削除画面

#### No1
<img width="1440" alt="diary-show-1" src="https://user-images.githubusercontent.com/69949838/102036229-a2155e00-3e05-11eb-9b5c-40f31784a505.png">

<img width="1440" alt="diary-show-2" src="https://user-images.githubusercontent.com/69949838/102036256-ae99b680-3e05-11eb-9184-24c9b94f9262.png">

日記一覧表示画面から、閲覧したい日記写真の右横の「▼」部分に、マウスを動かすとメニューが下に開き、「詳細」を押すと画面が遷移します。詳細画面には、写真、日付、タイトル、感想が表示されています。また一覧表示画面と同様、写真の右横の「▼」部分に、マウスを動かすとメニューが下に開き、「編集」、「削除」が表示される仕様となっています。

### 作成画面

#### No1
<img width="1440" alt="diary-write-1" src="https://user-images.githubusercontent.com/69949838/102036290-ca04c180-3e05-11eb-910b-b351d7c3dc1e.png">

<img width="1440" alt="diary-write-2" src="https://user-images.githubusercontent.com/69949838/102036311-d557ed00-3e05-11eb-8daa-03fa8edb496a.png">

日記を作成したい場合は、日記一覧表示画面から「日記を書く」をマウスで押すと、登録したい料理日記の写真、日付、タイトル、感想、を入力すると、作成ができます。また入力内容に不備があった場合は、ユーザー新規登録画面同様、日本語のエラーメッセージが表示されます。

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