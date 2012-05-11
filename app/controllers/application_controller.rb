class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_themes

  def load_themes
  	@themecookie = cookies[:codex_theme] || "newspaper"
	@themes = {
		:newspaper => "Newspaper",
		:novel => "Novel",
		:ebook => "EBook",
		:inverse => "Inverse",
		:athelas => "Athelas"
	}
  end
end
