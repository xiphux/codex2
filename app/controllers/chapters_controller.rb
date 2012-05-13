class ChaptersController < ApplicationController

  def show
    @fic = Fic.find(params[:fic_id])
    @chapter = Chapter.select(:data).find(:first, :conditions => { :fic_id => params[:fic_id], :number => params[:id] })
    @chapter.views += 1
    @chapter.save()

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

end
