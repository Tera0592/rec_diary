require 'rails_helper'

RSpec.describe "ユーザー新規登録機能", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context "ユーザーが新規登録ができるとき" do
    
    it '正しい情報を入力すればユーザ新規登録ができてトップページに移動する' do
      
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # 登録情報(ニックネーム、メールアドレス、パスワード、確認用のパスワード)を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email',    with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      # 会員登録ボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # 会員登録ページへ遷移するボタンやログインページへ遷移するボタンが表示されていない
      expect(page).to have_no_content ('新規登録')
      expect(page).to have_no_content ('ログイン')
      
    end

  end

  context "ユーザが新規登録ができないとき" do
    
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # 登録情報(ニックネーム、メールアドレス、パスワード、確認用のパスワード)を入力する
      fill_in 'nickname', with: ""
      fill_in 'email', with: ""
      fill_in 'password', with: ""
      fill_in 'password-confirmation', with: ""
      # 会員登録ボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 会員登録ページへ戻される
      expect(current_path).to eq "/users"

    end

  end

end
