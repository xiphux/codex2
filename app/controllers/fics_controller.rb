class FicsController < ApplicationController
  # GET /fics
  # GET /fics.json
  def index

    @search_series = nil
    @search_genres = nil
    @search_matchups = nil

    if params[:s] || params[:g] || params[:m] then
      @fics = Fic.scoped
      if params[:s] then
        for series_id in params[:s] do
	  @fics = @fics.with_series(series_id)
	  @search_series = [] if @search_series == nil
	  @search_series.push(Series.find(series_id))
	end
      end
      if params[:g] then
        for genre_id in params[:g] do
	  @fics = @fics.with_genre(genre_id)
	  @search_genres = [] if @search_genres == nil
	  @search_genres.push(Genre.find(genre_id))
	end
      end
      if params[:m] then
        for matchup_id in params[:m] do
	  @fics = @fics.with_matchup(matchup_id)
	  @search_matchups = [] if @search_matchups == nil
	  @search_matchups.push(Matchup.find(matchup_id))
	end
      end
      @fics = @fics.order('title')
    else
      @fics = Fic.order('title')
    end

    @series = []
    series_hash = {}

    @genres = []
    genre_hash = {}

    @matchups = []
    matchup_hash = {}

    for fic in @fics

      for series in fic.series
        if !series_hash.has_key?(series.id)
	  series_hash[series.id] = 1
	  @series.push(series)
	end
      end

      for genre in fic.genres
        if !genre_hash.has_key?(genre.id)
	  genre_hash[genre.id] = 1
	  @genres.push(genre)
	end
      end

      for matchup in fic.matchups
        if !matchup_hash.has_key?(matchup.id)
	  matchup_hash[matchup.id] = 1
	  @matchups.push(matchup)
	end
      end

    end

    @series.sort_by! { |s| s.title }
    @genres.sort_by! { |g| g.name }
    @matchups.sort_by! { |m| matchup.to_s }

    @search_series.sort_by! { |s| s.title } if @search_series != nil
    @search_genres.sort_by! { |g| g.name } if @search_genres != nil
    @search_matchups.sort_by! { |m| m.to_s } if @search_matchups != nil

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fics }
    end
  end

  # GET /fics/1
  # GET /fics/1.json
  def show
    @fic = Fic.find(params[:id])

    if @fic.chapters.count == 1 then
      redirect_to fic_chapter_path(@fic, @fic.chapters.first)
      return
    end

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
