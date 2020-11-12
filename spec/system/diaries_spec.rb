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
      # トップページには先ほど投稿した日記が存在する
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


