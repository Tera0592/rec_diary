require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザーを新規登録する' do
    
    context '新規登録ができるとき' do
      
      it '全ての項目が存在すれば正常に登録できる' do
        expect(@user).to be_valid
      end

    end

    context '新規登録ができないとき' do
      
      # ~がなければ登録ができないテスト
      
      it 'ニックネームがなければ登録ができない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームは20文字以内で入力してください。")
      end

      it 'メールアドレスがなければ登録ができない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスが入力されていません。", "メールアドレスは@を含めて入力してください。")
      end

      it 'パスワードがなければ登録ができない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードが入力されていません。", "パスワードは6文字以上に設定して下さい。", "パスワードは6文字以上の半角英数字で入力してください。")
      end

      # メールアドレス関連のテスト

      it 'メールアドレスが重複して存在すると登録ができない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスは既に使用されています。")
      end

      it 'メールアドレスに@がないとき登録ができない' do
        @user.email = 'abcdeyahoo.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは@を含めて入力してください。")
      end

      # パスワード関連のテスト

      it 'パスワードが５文字以下だと登録ができない' do
        @user.password = 'abcde'
        @user.password_confirmation = 'abcde'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上に設定して下さい。")
      end

      it 'パスワードが存在しても確認用パスワードが空だと登録ができない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("確認用パスワードを入力してください。")
      end

    end

  end

end
