class Fic < ActiveRecord::Base
  attr_accessible :title
  validates :title, :presence => true
  has_many :chapters
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
  scope :with_matchup, lambda { |genre| genre.present? ? {:conditions => ["fics.id in (SELECT fic_id FROM fics_matchups WHERE matchup_id = ?)", genre]} : {} }

  def to_s
    self.title
  end

  def word_count
    chapters.inject(0){ |sum, chap| sum + chap.word_count }
  end
end
