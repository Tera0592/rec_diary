class Recipe < ApplicationRecord
  # バリデーション
  
  # 空のカラムは保存ができない
  validates :name,  presence:                                       { message: "を入力してください。" }
  validates :image, presence:                                       { message: "のファイルを選択してください。" }
  validates :genre, :food, :seasoning, :procedure, presence:        { message: "を入力してください。" }

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :genre_id, numericality: { other_than: 1 , message: "は --- 以外を選択してください。" }

  # アソシエーション
  
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
end
