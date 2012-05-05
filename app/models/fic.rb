class Fic < ActiveRecord::Base
  attr_accessible :title
  validates :title, :presence => true
  has_many :chapters
end
