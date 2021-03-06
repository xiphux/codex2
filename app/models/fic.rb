class Fic < ActiveRecord::Base
  attr_accessible :title
  validates :title, :presence => true
  has_many :chapters, :order => 'number'
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :matchups
  has_and_belongs_to_many :series
  has_one :sequel, :class_name => "Fic", :foreign_key => "prequel_id"
  belongs_to :prequel, :class_name => "Fic", :foreign_key => "prequel_id"
  has_many :sidestories, :class_name => "Fic", :foreign_key => "main_story_id"
  belongs_to :main_story, :class_name => "Fic", :foreign_key => "main_story_id"

  scope :with_series, lambda { |series| series.present? ? {:conditions => ["fics.id in (SELECT fic_id FROM fics_series WHERE series_id = ?)", series]} : {} }
  scope :with_genre, lambda { |genre| genre.present? ? {:conditions => ["fics.id in (SELECT fic_id FROM fics_genres WHERE genre_id = ?)", genre]} : {} }
  scope :with_matchup, lambda { |matchup| matchup.present? ? {:conditions => ["fics.id in (SELECT fic_id FROM fics_matchups WHERE matchup_id = ?)", matchup]} : {} }
  scope :with_keyword, lambda { |keyword| keyword.present? ? {:conditions => ["fics.title LIKE ?", "%" + keyword + "%"]} : {} }
  scope :with_keyword_or_author, lambda { |keyword| keyword.present? ? {:conditions => ["fics.title LIKE ? OR fics.id in (SELECT fic_id FROM authors_fics LEFT JOIN authors ON authors_fics.author_id=authors.id WHERE authors.name LIKE ?)", "%" + keyword + "%", "%" + keyword + "%"]} : {} }

  def to_s
    self.title
  end

  def word_count
    Chapter.sum(:word_count, :conditions => ["fic_id = ?", id])
  end

  def views
    Chapter.sum(:views, :conditions => ["fic_id = ?", id])
  end
end
