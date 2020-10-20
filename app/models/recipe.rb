class Recipe < ApplicationRecord
  # バリデーション
  
  # 空のカラムは保存ができない
  validates :name, :image, :genre, :food, :seasoning, :procedure, presence: true
  # ジャンルの選択が「---」の時は保存できないようにする
  validates :genre_id, numericality: { other_than: 1 }

  # アソシエーション
  
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre
end
