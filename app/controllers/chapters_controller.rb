class ChaptersController < ApplicationController

  def show
    @fic = Fic.find(params[:fic_id])
    @chapter = Chapter.select(:data).find(:first, :conditions => { :fic_id => params[:fic_id], :number => params[:id] })

    respond_to do |format|
      format.html
      format.json
    end
  end

end
