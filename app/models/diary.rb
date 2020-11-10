class Diary < ApplicationRecord

  # バリデーション

  # 空のカラムは保存ができない
  
  validates :time,                         presence:                { message: "を選択してください。" }
  validates :image,                        presence:                { message: "のファイルを選択してください。" }
  validates :title, :impression,           presence:                { message: "を入力してください。" }

  
  # アソシエーション
  
  belongs_to :user
  has_one_attached :image

end
