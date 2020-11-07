class DiariesController < ApplicationController

  def index
    @diaries = Diary.all.order(id: 'DESC')
  end

  def new
    @diary = Diary.new
  end
  
end
