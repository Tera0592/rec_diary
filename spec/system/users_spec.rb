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
      # 正しい登録情報(ニックネーム、メールアドレス、パスワード、確認用のパスワード)を入力する
      fill_in 'nickname',              with: @user.nickname
      fill_in 'email',                 with: @user.email
      fill_in 'password',              with: @user.password
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
      # 誤った登録情報(ニックネーム、メールアドレス、パスワード、確認用のパスワード)を入力する
      fill_in 'nickname',              with: ""
      fill_in 'email',                 with: ""
      fill_in 'password',              with: ""
      fill_in 'password-confirmation', with: ""
      # 会員登録ボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 会員登録ページへ戻される
      expect(current_path).to eq user_registration_path(@user)

    end

  end

end

RSpec.describe "ユーザーログイン機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.build(:user)
  end

  context "ログインができるとき" do
    
    it '登録されているユーザーの情報と合致すればログインができる' do
      
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しい登録情報(ニックネーム、メールアドレス、パスワード、確認用のパスワード)を入力する
      fill_in 'email',    with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # 会員登録ページへ遷移するボタンやログインページへ遷移するボタンが表示されていない
      expect(page).to have_no_content ('新規登録')
      expect(page).to have_no_content ('ログイン')
      
    end

  end

  context "ログインができないとき" do
    
    it '登録されているユーザの情報と合致しないとログインができない' do
      
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 誤った登録情報(ニックネーム、メールアドレス、パスワード、確認用のパスワード)を入力する
      fill_in 'email',    with: @another.email
      fill_in 'password', with: @another.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻される
      expect(current_path).to eq new_user_session_path

    end

  end

end

RSpec.describe "ユーザー登録情報の編集機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.build(:user)
  end

  context "登録情報の編集ができるとき" do
    
    it 'ログインしているユーザーが登録情報を編集することができる' do
      
      # ログインする
      log_in(@user)
      # ニックネームの部分に、マウスを持ってくと"マイページ"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('マイページ')
      # マイページに移動する
      visit user_path(@user)
      # マイページに"編集する"ボタンがある
      expect(page).to have_content ('編集する')
      # ユーザー登録情報編集ページに移動する
      visit edit_user_path(@user)
      # 変更したいニックネームとメールアドレスに編集する
      fill_in 'nickname', with: @another.nickname
      fill_in 'email',    with: @another.email
      # "更新する"ボタンを押してもUserモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # マイページへ遷移する
      expect(current_path).to eq user_path(@user)
      # マイページには先ほど変更したニックネーム、メールアドレスがある
      expect(page).to have_content (@another.nickname)
      expect(page).to have_content (@another.email)
      
    end

  end

  context "登録情報の編集ができないとき" do
    
    it '誤った情報ではユーザーの登録情報が編集できずに編集ページへ戻ってくる' do
      
      # ログインする
      log_in(@user)
      # ニックネームの部分に、マウスを持ってくと"マイページ"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('マイページ')
      # マイページに移動する
      visit user_path(@user)
      # マイページに"編集する"ボタンがある
      expect(page).to have_content ('編集する')
      # ユーザー登録情報編集ページに移動する
      visit edit_user_path(@user)
      # 誤ったニックネームとメールアドレスに編集する
      fill_in 'nickname', with: ""
      fill_in 'email',    with: ""
      # "更新する"ボタンを押す
      find('input[name="commit"]').click
      # ユーザー登録情報編集ページへ戻される
      expect(current_path).to eq user_path(@user)
      
    end

  end

end
