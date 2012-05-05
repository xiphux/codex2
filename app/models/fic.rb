class Fic < ActiveRecord::Base
  attr_accessible :title
  validates :title, :presence => true
  has_many :chapters
  has_and_belongs_to_many :authors
end
