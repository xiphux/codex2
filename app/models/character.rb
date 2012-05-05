class Character < ActiveRecord::Base
  belongs_to :series
  attr_accessible :name
end
