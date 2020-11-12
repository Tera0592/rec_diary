class DiariesController < ApplicationController
  before_action :set_diary, only: [:show]

  def index
    @diary = Diary.includes(:user).order("time DESC")
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to diaries_path
    else
      render :new
    end
  end

  def show
    
  end

  private

  def set_diary
    @diary = Diary.includes(:user).find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:image, :time, :title, :impression).merge(user_id: current_user.id)
  end
  
end
