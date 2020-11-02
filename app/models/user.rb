class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :nickname,              presence:                                        {                          message: "は20文字以内で入力してください。"} 
  validates :email,                 presence: true, uniqueness: true,        format: { with: /[@]/,             message: "は@を含めて入力してください。"}
  validates :password,              presence: true, length: { minimum: 6 },  format: { with: /\A[a-z0-9]+\z/i,  message: "は6文字以上の半角英数字で入力してください。" }, on: :create
  validates :password_confirmation, presence:                                        {                          message: "を入力してください。"} , on: :create
  
  has_many  :recipes
  has_many  :diaries
end
