class Series < ActiveRecord::Base
  attr_accessible :title
  has_many :characters
end
