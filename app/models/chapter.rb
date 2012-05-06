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

  def text
    if file != nil
      # file content
    else
      data
    end
  end

  def word_count
    text_data = self.text
    if text_data != nil then
      text_data.split.size
    else
      0
    end
  end
end
