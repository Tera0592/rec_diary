class UsersController < ApplicationController
  
  def show
    @nickname = current_user.nickname
    @email = current_user.email
    @recipes = current_user.recipes
  end

  def edit
    
  end

end
