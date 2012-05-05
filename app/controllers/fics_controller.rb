class FicsController < ApplicationController
  # GET /fics
  # GET /fics.json
  def index
    @fics = Fic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fics }
    end
  end

  # GET /fics/1
  # GET /fics/1.json
  def show
    @fic = Fic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fic }
    end
  end

  # GET /fics/new
  # GET /fics/new.json
  def new
    @fic = Fic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fic }
    end
  end

  # GET /fics/1/edit
  def edit
    @fic = Fic.find(params[:id])
  end

  # POST /fics
  # POST /fics.json
  def create
    @fic = Fic.new(params[:fic])

    respond_to do |format|
      if @fic.save
        format.html { redirect_to @fic, notice: 'Fic was successfully created.' }
        format.json { render json: @fic, status: :created, location: @fic }
      else
        format.html { render action: "new" }
        format.json { render json: @fic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fics/1
  # PUT /fics/1.json
  def update
    @fic = Fic.find(params[:id])

    respond_to do |format|
      if @fic.update_attributes(params[:fic])
        format.html { redirect_to @fic, notice: 'Fic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fics/1
  # DELETE /fics/1.json
  def destroy
    @fic = Fic.find(params[:id])
    @fic.destroy

    respond_to do |format|
      format.html { redirect_to fics_url }
      format.json { head :no_content }
    end
  end
end
