class Matchup < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :fics
  has_and_belongs_to_many :characters

  def to_s
    same_series = true
    first_series = nil
    for character in self.characters
      if first_series == nil then
        first_series = character.series
      elsif first_series != character.series
        same_series = false
	break
      end
    end

    self.characters.map { |c| same_series ? c.name : c.name_and_series }.join("+")
  end
end
