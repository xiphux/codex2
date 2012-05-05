class Character < ActiveRecord::Base
  belongs_to :series
  attr_accessible :name
  has_and_belongs_to_many :matchups
end
