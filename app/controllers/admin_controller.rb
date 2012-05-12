class AdminController < ApplicationController
  def index
    respond_to do |format|
      format.html
    end
  end

  def update_word_counts
    @chapters = Chapter.select(:data).all
    @chapters.each do |chapter|
      word_count = chapter.calculate_word_count
      if word_count != chapter.word_count then
        chapter.word_count = word_count
        chapter.save
      end
    end

    redirect_to :action => "index"
  end
end
