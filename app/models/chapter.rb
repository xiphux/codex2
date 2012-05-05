class Chapter < ActiveRecord::Base
  belongs_to :fic
  attr_accessible :data, :file, :number, :padlines, :title, :views, :wrapped
end
