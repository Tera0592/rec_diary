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
      # ニックネームの部分に、マウスを持ってくと"レシピを投稿する"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('レシピを投稿する')
      # レシピ投稿ページに移動する
      visit new_recipe_path
      # フォームに情報を入力する
      image_path = Rails.root.join('spec/fixtures/recipe/recipe_test_image.jpg')
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
      # トップページには先ほど投稿したレシピが存在する
      expect(page).to have_selector "img[src$='recipe_test_image.jpg']"

    end

    it 'ログインしたユーザーはマイページからレシピ投稿ができる' do
      
      # ログインする
      log_in(@user)
      # ニックネームの部分に、マウスを持ってくと"マイページ"へ遷移するボタンがある
      expect(
        find(".user-nickname").hover
      ).to have_content ('マイページ')
      # マイページへ遷移する
      visit user_path(@user)
      # マイページに"レシピを投稿する"のボタンがある
      expect(page).to have_content ('レシピを投稿する')
      # レシピ投稿ページに移動する
      visit new_recipe_path
      # フォームに情報を入力する
      image_path = Rails.root.join('spec/fixtures/recipe/recipe_test_image.jpg')
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
      # トップページには先ほど投稿したレシピが存在する
      expect(page).to have_selector "img[src$='recipe_test_image.jpg']"

    end

  end

  context "レシピが投稿できないとき" do
    
    it 'ログインしていないとレシピ投稿ができない' do
      
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
    expect(page).to have_selector "img[src$='recipe_test_image.jpg']"
    expect(page).to have_content(@recipe1.name)
    expect(page).to have_content(@recipe1.food)
    expect(page).to have_content(@recipe1.seasoning)
    expect(page).to have_content(@recipe1.procedure)
    
  end

  it 'ログインしてないユーザーがレシピ詳細ページを閲覧できる' do
  
    # トップページに遷移する
    visit root_path
    # 投稿されているレシピの詳細ページに遷移する
    click_on(@recipe1.name)
    visit recipe_path(@recipe1)
    # レシピ詳細ページにレシピの内容が含まれる
    expect(page).to have_selector "img[src$='recipe_test_image.jpg']"
    expect(page).to have_content(@recipe1.name)
    expect(page).to have_content(@recipe1.food)
    expect(page).to have_content(@recipe1.seasoning)
    expect(page).to have_content(@recipe1.procedure)
    
  end

end

RSpec.describe "レシピ編集", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
    @another_recipe = FactoryBot.build(:recipe)
  end

  context "レシピ編集ができるとき" do
    
    it 'ログインしたユーザーはトップページから自分が投稿したレシピの編集ができる' do
      
      # レシピ1を投稿したユーザーでログインする
      log_in(@recipe1.user)
      # 投稿されたレシピの詳細ページに遷移する
      click_on(@recipe1.name)
      visit recipe_path(@recipe1)
      # レシピ詳細ページに"レシピの編集"のボタンがある
      expect(page).to have_content ('レシピの編集')
      # レシピ編集ページに遷移する
      visit edit_recipe_path(@recipe1)
      # すでに投稿ずみのレシピ内容がフォームに入っている
      expect(
        find('#recipe-name').value
      ).to eq @recipe1.name
      expect(
        find('#recipe-food').value
      ).to eq @recipe1.food
      expect(
        find('#recipe-seasoning').value
      ).to eq @recipe1.seasoning
      expect(
        find('#recipe-procedure').value
      ).to eq @recipe1.procedure
      # レシピ投稿内容を編集する
      another_recipe_image_path = Rails.root.join('spec/fixtures/recipe/another_recipe_test_image.jpg')
      attach_file('recipe[image]', another_recipe_image_path, make_visible: true)
      fill_in 'recipe-name',       with: @another_recipe.name
      select  'デザート',           from: "recipe-genre"
      fill_in 'recipe-food',       with: @another_recipe.food
      fill_in 'recipe-seasoning',  with: @another_recipe.seasoning
      fill_in 'recipe-procedure',  with: @another_recipe.procedure
      # "レシピを編集する"を押してもRecipeモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { Recipe.count }.by(0)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど編集したレシピ(写真、料理名)が存在する
      expect(page).to have_selector "img[src$='another_recipe_test_image.jpg']"
      expect(page).to have_content(@another_recipe.name)

    end

    it 'ログインしたユーザーはマイページから自分が投稿したレシピの編集ができる' do
      
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
      # レシピ詳細ページに"レシピの編集"のボタンがある
      expect(page).to have_content ('レシピの編集')
      # レシピ編集ページに遷移する
      visit edit_recipe_path(@recipe1)
      # すでに投稿ずみのレシピ内容がフォームに入っている
      expect(
        find('#recipe-name').value
      ).to eq @recipe1.name
      expect(
        find('#recipe-food').value
      ).to eq @recipe1.food
      expect(
        find('#recipe-seasoning').value
      ).to eq @recipe1.seasoning
      expect(
        find('#recipe-procedure').value
      ).to eq @recipe1.procedure
      # レシピ投稿内容を編集する
      another_recipe_image_path = Rails.root.join('spec/fixtures/recipe/another_recipe_test_image.jpg')
      attach_file('recipe[image]', another_recipe_image_path, make_visible: true)
      fill_in 'recipe-name',       with: @another_recipe.name
      select  'デザート',           from: "recipe-genre"
      fill_in 'recipe-food',       with: @another_recipe.food
      fill_in 'recipe-seasoning',  with: @another_recipe.seasoning
      fill_in 'recipe-procedure',  with: @another_recipe.procedure
      # "レシピを編集する"を押してもRecipeモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { Recipe.count }.by(0)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど編集したレシピ(写真、料理名)が存在する
      expect(page).to have_selector "img[src$='another_recipe_test_image.jpg']"
      expect(page).to have_content(@another_recipe.name)

    end

  end

  context "レシピが編集できないとき" do
    
    it 'ログインしたユーザーは自分以外が投稿したレシピの編集画面には遷移できない' do
      
      # レシピ1を投稿したユーザーでログインする
      log_in(@recipe1.user)
      # レシピ2の詳細ページに遷移する
      click_on(@recipe2.name)
      visit recipe_path(@recipe2)
      # レシピ2の詳細ページに"レシピの編集"のボタンがない
      expect(page).to have_no_content ('レシピの編集')

    end

    it 'ログインしていないと投稿されているレシピの編集画面には遷移できない' do
      
      # トップページに遷移する
      visit root_path
      # レシピ1の詳細ページに遷移する
      click_on(@recipe1.name)
      visit recipe_path(@recipe1)
      # レシピ1の詳細ページに"レシピの編集"のボタンがない
      expect(page).to have_no_content ('レシピの編集')

    end

  end

end

RSpec.describe "レシピ削除", type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end
  
  context "レシピ削除ができるとき" do
    
    it 'ログインしたユーザーはトップページから自分が投稿したレシピの削除ができる' do
      
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
