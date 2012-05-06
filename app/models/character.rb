class Character < ActiveRecord::Base
  belongs_to :series
  attr_accessible :name
  has_and_belongs_to_many :matchups
  
  def to_s
    self.name
  end

  def name_and_series
    "#{self.name} (#{self.series.title})"
  end
end
