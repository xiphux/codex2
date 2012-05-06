class Chapter < ActiveRecord::Base
  belongs_to :fic
  attr_accessible :data, :file, :number, :padlines, :title, :views, :wrapped

  def to_s
    if self.title != nil then
      self.title
    else
      "Chapter #{number}"
    end
  end
end
