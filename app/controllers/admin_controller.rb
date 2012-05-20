class AdminController < ApplicationController
  def index
    respond_to do |format|
      format.html
    end
  end

  def update_word_counts
    @chapters = Chapter.select(:data).all
    @chapters.each do |chapter|
      word_count = chapter.calculate_word_count
      if word_count != chapter.word_count then
        chapter.word_count = word_count
        chapter.save
      end
    end

    redirect_to :action => "index"
  end

  def prune_text_transforms

    TextTransform.delete_all("chapter_id IS NULL OR chapter_id not in (SELECT id FROM chapters)")

    @chapters = Chapter.select(:data).all
    @chapters.each do |chapter|

    	next if chapter.text_transforms.count < 1

	chapter_patterns = Hash.new

	chapter.text_transforms.each do |transform|
	  if transform.pattern == nil || transform.pattern.blank? then
	    # empty
	    transform.delete
	    next
	  end

	  if chapter_patterns.has_key?(transform.pattern) then
	    # duplicate
	    transform.delete
	    next
	  end

	  regex = Regexp.new(transform.pattern)
	  if !regex then
	    # invalid pattern
	    transform.delete
	    next
	  end

	  if !regex.match(chapter.text) then
	    # useless pattern
	    transform.delete
	    next
	  end

	  chapter_patterns[transform.pattern] = 1
	end

    end

    redirect_to :action => "index"
  end
end
