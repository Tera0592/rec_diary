require 'rails_helper'

RSpec.describe Recipe, type: :model do
  
  before do
    @recipe = FactoryBot.build(:recipe)
    @recipe.image = fixture_file_upload('public/images/test_image.png')
  end

  describe 'レシピを投稿する' do
    
    context 'レシピ投稿がうまくいくとき' do
      
      it '全ての項目が存在すれば正常に投稿ができる' do
        expect(@recipe).to be_valid
      end

    end

    context 'レシピ投稿ができないとき' do
      
      # ~がなければ投稿ができない

      it '料理名が入力されてなければ投稿ができない' do
        @recipe.name = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("料理名を入力してください。")
      end

      it '料理の写真が選択されてなければ投稿ができない' do
        @recipe.image = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("料理の写真のファイルを選択してください。")
      end

      it 'ジャンルが選択されてなければ投稿ができない' do
        @recipe.genre_id = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("ジャンルを選択してください。", "ジャンルは --- 以外を選択してください。")
      end

      it '材料が入力されてなければ投稿ができない' do
        @recipe.food = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("材料を入力してください。")
      end

      it '調味料が入力されてなければ投稿ができない' do
        @recipe.seasoning = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("調味料を入力してください。")
      end

      it '作り方が入力されてなければ投稿ができない' do
        @recipe.procedure = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("作り方を入力してください。")
      end

      # ジャンルの選択が --- のときはレシピが投稿ができない

      it 'ジャンルの選択が --- のときはレシピが投稿ができない' do
        @recipe.genre_id = 1
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("ジャンルは --- 以外を選択してください。")
      end

    end

  end

end
