class Chapter < ActiveRecord::Base
  belongs_to :fic
  attr_accessible :data, :file, :number, :padlines, :title, :wrapped, :word_count, :views

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

  def calculate_word_count
    text_data = self.text
    if text_data != nil then
      wordcount = text_data.split.size
    else
      wordcount = 0
    end
  end

  def word_count
    wordcount = read_attribute(:word_count)
    if wordcount == nil then
      wordcount = calculate_word_count
    end
    wordcount
  end
end
