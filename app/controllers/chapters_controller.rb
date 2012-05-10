class ChaptersController < ApplicationController

  def show
    @fic = Fic.find(params[:fic_id])
    @chapter = Chapter.all(:conditions => { :fic_id => params[:fic_id], :number => params[:id] }).first

    respond_to do |format|
      format.html
      format.json
    end
  end

end
