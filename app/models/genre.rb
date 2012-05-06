class Genre < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :fics

  def to_s
    self.name
  end
end
