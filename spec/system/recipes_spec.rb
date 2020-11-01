require 'rails_helper'

RSpec.describe "レシピ投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @recipe_name = Faker::Food.dish
    @recipe_food = Faker::Food.ingredient
    @recipe_seasoning = Faker::Food.spice
    @recipe_procedure = Faker::Food.description 
  end

  context "レシピ投稿ができるとき" do
    
    it 'ログインしたユーザーはレシピ投稿ができる' do
      
      # ログインする
      log_in(@user)
      # ユーザーニックネームが表示されているボタンを押すと"レシピを投稿する"へ遷移するボタンがある
      click_link ('user')
      expect(page).to have_content ('レシピを投稿する')
      # レシピ投稿ページに移動する
      visit new_recipe_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('recipe[image]', image_path, make_visible: true)
      fill_in 'recipe-name',       with: @recipe_name
      select  '和食',              from: "recipe-genre"
      fill_in 'recipe-food',       with: @recipe_food
      fill_in 'recipe-seasoning',  with: @recipe_seasoning
      fill_in 'recipe-procedure',  with: @recipe_procedure
      # "レシピを投稿する"を押すとRecipeモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Recipe.count }.by(1)
      # トップページ(レシピ一覧表示ページ)に遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿したレシピ(写真、料理名)が存在する
      expect(page).to have_selector "img"
      expect(page).to have_content(@recipe_name)

    end

  end

  context "レシピが投稿できないとき" do
    
    it 'ログインしていないとレシピ投稿ページができない' do
      
      # トップページに遷移する
      visit root_path
      # レシピ投稿ページへのリンクがない
      expect(page). to have_no_content('レシピを投稿する')
      
    end

  end

end

RSpec.describe "レシピ詳細", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @recipe1 = FactoryBot.create(:recipe)
  end
  
  it 'ログインしたユーザーがレシピ詳細ページを閲覧できる' do
    
    # 新規登録済みのユーザーでログインする
    log_in(@user1)
    # 投稿されているレシピの詳細ページに遷移する
    click_on(@recipe1.name)
    visit recipe_path(@recipe1)
    # レシピ詳細ページにレシピの内容が含まれる
    expect(page).to have_content(@recipe_name)
    expect(page).to have_content(@recipe_food)
    expect(page).to have_content(@recipe_seasoning)
    expect(page).to have_content(@recipe_procedure)
    
  end

  it 'ログインしてないユーザーがレシピ詳細ページを閲覧できる' do
  
    # トップページに遷移する
    visit root_path
    # 投稿されているレシピの詳細ページに遷移する
    click_on(@recipe1.name)
    visit recipe_path(@recipe1)
    # レシピ詳細ページにレシピの内容が含まれる
    expect(page).to have_content(@recipe_name)
    expect(page).to have_content(@recipe_food)
    expect(page).to have_content(@recipe_seasoning)
    expect(page).to have_content(@recipe_procedure)
    
  end

end


