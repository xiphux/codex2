class FicsController < ApplicationController
  # GET /fics
  def index

    @search_series = nil
    @search_genres = nil
    @search_matchups = nil

    if params[:s] || params[:g] || params[:m] || (params[:search] && !params[:search].blank?) then

      filter_fics = nil
      keyword_fics = nil

      # filter search
      if params[:s] || params[:g] || params[:m] then
        filter_fics = Fic.includes(:series, :genres, :matchups, :authors).scoped
        if params[:s] then
          for series_id in params[:s] do
	    filter_fics = filter_fics.with_series(series_id)
	    @search_series = [] if @search_series == nil
	    @search_series.push(Series.find(series_id))
	  end
        end
        if params[:g] then
          for genre_id in params[:g] do
	    filter_fics = filter_fics.with_genre(genre_id)
	    @search_genres = [] if @search_genres == nil
	    @search_genres.push(Genre.find(genre_id))
	  end
        end
        if params[:m] then
          for matchup_id in params[:m] do
	    filter_fics = filter_fics.with_matchup(matchup_id)
	    @search_matchups = [] if @search_matchups == nil
	    @search_matchups.push(Matchup.find(matchup_id))
	  end
        end
        filter_fics = filter_fics.order('title')
      end

      # keyword search
      if (params[:search] && !params[:search].blank?) then

	keyword_fics = Fic.includes(:series, :genres, :matchups, :authors).scoped
	for keyword in params[:search].split(' ') do
	  keyword_fics = keyword_fics.with_keyword_or_author(keyword)
	end

      end

      if filter_fics != nil && keyword_fics != nil then
        @fics = filter_fics & keyword_fics
      elsif filter_fics != nil then
        @fics = filter_fics
      elsif keyword_fics != nil then
        @fics = keyword_fics
      end

    end

    @series = []
    series_hash = {}

    @genres = []
    genre_hash = {}

    @matchups = []
    matchup_hash = {}

    if @fics then

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
      @matchups.sort_by! { |m| m.name_without_series }

    else

      @series = Series.order('title')
      @genres = Genre.order('name')
      @matchups = Matchup.all.sort_by { |m| m.name_without_series }

    end

    @search_series.sort_by! { |s| s.title } if @search_series != nil
    @search_genres.sort_by! { |g| g.name } if @search_genres != nil
    @search_matchups.sort_by! { |m| m.to_s } if @search_matchups != nil

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /fics/1
  def show
    @fic = Fic.find(params[:id])

    if @fic.chapters.count == 1 then
      redirect_to fic_chapter_path(@fic, @fic.chapters.first)
      return
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
