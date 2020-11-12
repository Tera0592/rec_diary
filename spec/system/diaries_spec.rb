require 'rails_helper'

RSpec.describe "日記投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @diary_title = Faker::Lorem.word
    @diary_impression = Faker::Lorem.sentence
  end

  context "日記投稿ができるとき" do
    
    it "ログインしたユーザーは日記投稿ができる" do
      
      # ログインする
      log_in(@user)
      # ニックネームの部分に、マウスを持ってくと"日記一覧"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('日記一覧')
      # 日記一覧ページに移動する
      visit diaries_path
      # 日記一覧ページに"日記を書く"のボタンがある
      expect(page).to have_content ('日記を書く')
      # 日記投稿ページへ移動する
      visit new_diary_path
      # フォームに情報を入力する
      image_path = Rails.root.join('spec/fixtures/diary/diary_test_image.jpg')
      attach_file('diary[image]', image_path, make_visible: true)
      fill_in 'diary-title',       with: @diary_title
      fill_in 'diary-impression',  with: @diary_impression
      # "日記を投稿する"を押すとDiaryモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Diary.count }.by(1)
      # 日記一覧ページに遷移する
      expect(current_path).to eq diaries_path
      # 日記一覧ページには先ほど投稿した日記が存在する
      expect(page).to have_selector "img[src$='diary_test_image.jpg']"
      
    end

    it "ログインしたユーザーはマイページから日記投稿ができる" do
      
      # ログインする
      log_in(@user)
      # ニックネームの部分に、マウスを持ってくと"マイページ"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('マイページ')
      # マイページへ遷移する
      visit user_path(@user)
      # マイページに"日記を書く"のボタンがある
      expect(page).to have_content ('日記を書く')
      # 日記投稿ページへ移動する
      visit new_diary_path
      # フォームに情報を入力する
      image_path = Rails.root.join('spec/fixtures/diary/diary_test_image.jpg')
      attach_file('diary[image]', image_path, make_visible: true)
      fill_in 'diary-title',       with: @diary_title
      fill_in 'diary-impression',  with: @diary_impression
      # "日記を投稿する"を押すとDiaryモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Diary.count }.by(1)
      # 日記一覧ページに遷移する
      expect(current_path).to eq diaries_path
      # 日記一覧ページには先ほど投稿した日記が存在する
      expect(page).to have_selector "img[src$='diary_test_image.jpg']"
      
    end

  end

  context "日記が投稿できないとき" do
    
    it 'ログインしていないと日記投稿ができない' do
      
      # トップページに遷移する
      visit root_path
      # 日記一覧ページへのリンクがない
      expect(page). to have_no_content('日記一覧')
      
    end

  end

end

RSpec.describe "日記詳細", type: :system do
  before do
    @diary1 = FactoryBot.create(:diary)
    @another = FactoryBot.create(:user)
  end
  
  context "日記詳細ページが閲覧できるとき" do

    it 'ログインしたユーザーが日記詳細ページを閲覧できる' do
      
      # 日記投稿済みのユーザーでログインする
      log_in(@diary1.user)
      # ニックネームの部分に、マウスを持ってくと"日記一覧"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('日記一覧')
      # 日記一覧ページに移動する
      visit diaries_path
      # 投稿されている日記の"▼"部分に、マウスを持ってくと、"詳細"へ遷移するボタンがある
      expect(
        find(".preview").hover
      ).to have_content ('詳細')
      # 日記詳細ページへ遷移する
      visit diary_path(@diary1)
      # 日記詳細ページに日記の内容が含まれる
      expect(page).to have_selector "img[src$='diary_test_image.jpg']"
      expect(page).to have_content(@diary1.title)
      expect(page).to have_content(@diary1.impression)
      
    end

  end

  context "日記詳細ページが閲覧できないとき" do

    it 'ログインしていないとユーザーは日記詳細ページを閲覧できない' do
      
      # トップページに遷移する
      visit root_path
      # 日記一覧ページへのリンクがない
      expect(page). to have_no_content('日記一覧')
      
    end

    it 'ログインしても、投稿されている日記のユーザー以外は日記詳細ページを閲覧できない' do
      
      # すでに投稿されている日記のユーザー以外のユーザーでログインする
      log_in(@another)
      # ニックネームの部分に、マウスを持ってくと"日記一覧"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('日記一覧')
      # 日記一覧ページに移動する
      visit diaries_path
      # 日記一覧ページに、ログインユーザー以外の日記は存在しない
      expect(page).to have_no_selector "img[src$='diary_test_image.jpg']"
      
    end

  end
  
end

RSpec.describe "日記編集", type: :system do
  before do
    @diary1 = FactoryBot.create(:diary)
    @another_user = FactoryBot.create(:user)
    @another_diary = FactoryBot.build(:diary)
  end

  context "日記編集ができるとき" do
    
    it 'ログインしたユーザーは日記一覧ページから自分が投稿した日記の編集ができる' do
      
      # 日記投稿済みのユーザーでログインする
      log_in(@diary1.user)
      # ニックネームの部分に、マウスを持ってくと"日記一覧"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('日記一覧')
      # 日記一覧ページに移動する
      visit diaries_path
      # 投稿されている日記の"▼"部分に、マウスを持ってくと、"編集"へ遷移するボタンがある
      expect(
        find(".preview").hover
      ).to have_content ('編集')
      # 日記編集ページへ遷移する
      visit edit_diary_path(@diary1)
      # すでに投稿ずみの日記内容がフォームに入っている
      expect(
        find('#diary-title').value
      ).to eq @diary1.title
      expect(
        find('#diary-impression').value
      ).to eq @diary1.impression
      # 日記投稿内容を編集する
      another_diary_image_path = Rails.root.join('spec/fixtures/diary/another_diary_test_image.jpg')
      attach_file('diary[image]', another_diary_image_path, make_visible: true)
      fill_in 'diary-title',       with: @another_diary.title
      fill_in 'diary-impression',  with: @another_diary.impression
      # "日記を編集する"を押してもDiaryモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { Diary.count }.by(0)
      # 日記一覧ページに遷移する
      expect(current_path).to eq diaries_path
      # 日記一覧ページには先ほど編集した日記が存在する
      expect(page).to have_selector "img[src$='another_diary_test_image.jpg']"
      expect(page).to have_content(@another_diary.title)

    end

  end

  context "日記が編集できないとき" do
    
    it 'ログインしていないとユーザーは日記編集ページへ遷移できない' do
      
      # トップページに遷移する
      visit root_path
      # 日記一覧ページへのリンクがない
      expect(page). to have_no_content('日記一覧')
      
    end

    it 'ログインしても、投稿されている日記のユーザー以外は日記編集ページへ遷移できない' do
      
      # すでに投稿されている日記のユーザー以外のユーザーでログインする
      log_in(@another_user)
      # ニックネームの部分に、マウスを持ってくと"日記一覧"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('日記一覧')
      # 日記一覧ページに移動する
      visit diaries_path
      # 日記一覧ページに、ログインユーザー以外の日記は存在しない
      expect(page).to have_no_selector "img[src$='diary_test_image.jpg']"
      
    end

  end

end

RSpec.describe "日記削除", type: :system do
  before do
    @diary1 = FactoryBot.create(:diary)
  end
  
  context "日記削除ができるとき" do
    
    it 'ログインしたユーザーは日記一覧ページから自分が投稿した日記の削除ができる' do
      
      # 日記投稿済みのユーザーでログインする
      log_in(@diary1.user)
      # ニックネームの部分に、マウスを持ってくと"日記一覧"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('日記一覧')
      # 日記一覧ページに移動する
      visit diaries_path
      # 投稿されている日記の"▼"部分に、マウスを持ってくと、"詳細"へ遷移するボタンがある
      expect(
        find(".preview").hover
      ).to have_content ('編集')
      # レシピ1を投稿したユーザーでログインする
      log_in(@recipe1.user)
      # 投稿されたレシピの詳細ページに遷移する
      click_on(@recipe1.name)
      visit recipe_path(@recipe1)
      # レシピ詳細ページに"レシピの削除"のボタンがある
      expect(page).to have_content ('レシピの削除')
      # "レシピの削除"のボタンを押すとRecipeモデルのカウントが1下がる
      expect{
        find_link('レシピの削除', href: recipe_path(@recipe1)).click
      }.to change { Recipe.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど削除したレシピが存在しない
      expect(page).to have_no_content(@recipe1.name)
      
    end

    it 'ログインしたユーザーはマイページから自分が投稿したレシピの削除ができる' do
      
      # レシピ1を投稿したユーザーでログインする
      log_in(@recipe1.user)
      # ニックネームの部分に、マウスを持ってくと"マイページ"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('マイページ')
      # マイページへ遷移する
      visit user_path(@recipe1.user)
      # レシピ詳細ページに遷移する
      click_on(@recipe1.name)
      visit recipe_path(@recipe1)
      # レシピ詳細ページに"レシピの削除"のボタンがある
      expect(page).to have_content ('レシピの削除')
      # "レシピの削除"のボタンを押すとRecipeモデルのカウントが1下がる
      expect{
        find_link('レシピの削除', href: recipe_path(@recipe1)).click
      }.to change { Recipe.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど削除したレシピが存在しない
      expect(page).to have_no_content(@recipe1.name)
      
    end

  end

  context "レシピが削除できないとき" do
    
    it 'ログインしたユーザーは自分以外が投稿したレシピの削除画面には遷移できない' do
      
      # レシピ1を投稿したユーザーでログインする
      log_in(@recipe1.user)
      # レシピ2の詳細ページに遷移する
      click_on(@recipe2.name)
      visit recipe_path(@recipe2)
      # レシピ2の詳細ページに"レシピの削除"のボタンがない
      expect(page).to have_no_content ('レシピの削除')

    end

    it 'ログインしていないと投稿されているレシピの削除画面には遷移できない' do
      
      # トップページに遷移する
      visit root_path
      # レシピ1の詳細ページに遷移する
      click_on(@recipe1.name)
      visit recipe_path(@recipe1)
      # レシピ1の詳細ページに"レシピの削除"のボタンがない
      expect(page).to have_no_content ('レシピの削除')

    end

  end

end