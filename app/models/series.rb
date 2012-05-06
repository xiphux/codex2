class Series < ActiveRecord::Base
  attr_accessible :title
  has_many :characters
  has_and_belongs_to_many :fics

  def to_s
    self.title
  end
end
