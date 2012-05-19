class TextTransform < ActiveRecord::Base
  belongs_to :chapter
  attr_accessible :pattern, :replacement
end
