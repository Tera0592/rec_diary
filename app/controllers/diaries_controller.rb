class DiariesController < ApplicationController

  def index
    @diaries = Diary.all.order(id: 'DESC')
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

  private

  def diary_params
    params.require(:diary).permit(:image, :time, :title, :impression).merge(user_id: current_user.id)
  end
  
end
