class Fic < ActiveRecord::Base
  attr_accessible :title
  validates :title, :presence => true
  has_many :chapters
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :matchups
  has_and_belongs_to_many :series
  has_one :sequel, :class_name => "Fic"
  belongs_to :prequel, :class_name => "Fic", :foreign_key => "prequel_id"
  has_many :sidestories, :class_name => "Fic"
  belongs_to :main_story, :class_name => "Fic", :foreign_key => "main_story_id"
end
