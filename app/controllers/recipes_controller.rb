class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit]

  def index
    @recipe = Recipe.all.order(id: 'DESC')
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    
  end

  private

  def set_recipe
    @recipe = Recipe.includes(:user).find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:image, :name, :genre_id, :food, :seasoning, :procedure).merge(user_id: current_user.id)
  end

end


