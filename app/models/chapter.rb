class Chapter < ActiveRecord::Base
  belongs_to :fic
  attr_accessible :data, :file, :number, :padlines, :title, :wrapped, :word_count, :views
  default_scope select((column_names - ['data']).map { |column_name| "`#{table_name}`.`#{column_name}`"})

  def title
    fic_title = read_attribute(:title)
    if fic_title == nil then
      fic_title = "Chapter #{number}"
    end
    fic_title
  end

  def to_s
    title
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

  def to_param
    number
  end
end
