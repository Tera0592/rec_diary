require 'rails_helper'

RSpec.describe Diary, type: :model do
  before do
    @diary = FactoryBot.build(:diary)
  end

  describe '日記を投稿する' do
    
    context '日記投稿がうまくいくとき' do
      
      it '全ての項目が存在すれば正常に登録ができる' do
       expect(@diary).to be_valid 
      end

    end

    context '日記投稿ができないとき' do
      
      # ~がなければ投稿ができない

      it 'タイトルが入力されてなければ投稿ができない' do
       @diary.title = nil
       @diary.valid?
       expect(@diary.errors.full_messages).to include("タイトルを入力してください。")
      end

      it '日記の写真が選択されてなければ投稿ができない' do
        @diary.image = nil
        @diary.valid?
        expect(@diary.errors.full_messages).to include("日記の写真のファイルを選択してください。")
      end

      it '作った日時が選択されてなければ投稿ができない' do
        @diary.time = nil
        @diary.valid?
        expect(@diary.errors.full_messages).to include("作った日時を選択してください。")
      end

      it '感想が入力されてなければ投稿ができない' do
        @diary.impression = nil
        @diary.valid?
        expect(@diary.errors.full_messages).to include("感想を入力してください。")
      end

    end

  end

end
