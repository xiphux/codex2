class Matchup < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :fics
  has_and_belongs_to_many :characters
end
