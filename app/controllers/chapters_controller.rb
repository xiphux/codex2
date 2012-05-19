class ChaptersController < ApplicationController

  def show
    @fic = Fic.find(params[:fic_id])
    @chapter = Chapter.select(:data).find(:first, :conditions => { :fic_id => params[:fic_id], :number => params[:id] })
    @chapter.views += 1
    @chapter.save()
    @chapter_presenter = ChapterPresenter.new(@chapter)

    @textsizecookie = cookies[:codex_font_size] || "medium"
    @textsizes = {
    	:small => "Small",
	:medium => "Medium",
	:large => "Large"
    }

    respond_to do |format|
      format.html
    end
  end

  def add_transform
    @chapter = Chapter.find(:first, :conditions => { :fic_id => params[:fic_id], :number => params[:id] })
    if params[:spelling_original] && !params[:spelling_original].blank? then
      @chapter.text_transforms.create(:pattern => "\\b" + params[:spelling_original] + "\\b", :replacement => params[:spelling_replacement])
    end
    redirect_to :action => "show"
  end

end
