class ChapterPresenter

  def initialize(chapter)
    @chapter = chapter
  end

  def compact_blank_lines!(text)
    text.gsub!(/([^\n])(\n\s*){2,}\n(\s*[^\n])/) { |match| $1 + "\n\n" + $3 }
  end

  def compact_blank_lines(text)
    compacted_text = text.dup
    
    compact_blank_lines!(compacted_text)

    compacted_text
  end

  def unwrap!(text)
    lines = compact_blank_lines(text).split("\n")

    line_count = lines.count

    character_count = 0
    indented_line_count = 0
    space_ended_line_count = 0
    content_line_count = 0

    lines.each do |line|
      spaced_line = line.sub(/^ {2,}([^ ].*)$/) { |match| "\t" + $1 }

      indented_line_count += 1 if spaced_line =~ /^\t/

      space_ended_line_count += 1 if spaced_line =~ / $/

      character_count += spaced_line.length

      content_line_count += 1 if !spaced_line.strip.empty?
    end

    average_length = (character_count / content_line_count).to_i

    space_to_line_ratio = space_ended_line_count.to_f / content_line_count.to_f

    if space_to_line_ratio > 0.6 && space_to_line_ratio < 0.98 then
      # text has lots of lines that end in spaces
      # might be unwrappable by using the ending space
      # as an indication of text continuing on the next line
      text.gsub!(/ \n/, " ")
    elsif (indented_line_count.to_f / content_line_count.to_f) > 0.20 then
      # text appears to have a number of indented lines
      # try to use indents to find paragraphs
      text.gsub!(/ *\n(\S)/) { |match| " " + $1 }
    elsif (((line_count - content_line_count).to_f / line_count.to_f) > 0.10) then
      # text appears to have a number of blank lines
      # try to use blank lines to find paragraphs
      text.gsub!(/([^\n]) *\n([^\r\s])/) { |match| $1 + " " + $2 }
    elsif (average_length > 1) then
      # try to unwrap by guessing the width of lines
      regex = Regexp.new("([^\n]{" + average_length.to_i.to_s + ",})\n")
      text.gsub!(regex) { |match| $1 + " " }
      text.gsub!(/([\w,]) {2,}([\w,])/) { |match| $1 + " " + $2 }
    end

    # preserve breaklines that may have accidentally been wrapped up
    text.gsub!(/([^\*\-=\~_<>\^`#\$@A-Za-z])((([\*\-=\~_<>#\^`\$@]) ?){4,})([^\*\-=\~_<>#\^`\$@])/) { |match| $1 + "\n" + $2 + "\n" + $5 }
  end

  def stylize!(text)
    # stylize breaking lines
    text.gsub!(/\s*\n([\s\n])*((([\*\-=\~_\^`#\$@])|&lt;|&gt;) ?){3,}([\s\n])*\n/, "<div class=\"breakline\"></div>")

    # stylize underscore emphasis
    text.gsub!(/(\W)_(\S+?)_(\W)/) { |match| $1 + '<span class="emphasis">' + $2 + '</span>' + $3 }

    # stylize asterisk emphasis
    text.gsub!(/([^\*])(\*{1,2})([^\*>\n]*)(\*{1,2})([^\*])/) { |match| $1 + $2 + '<span class="emphasis">' + $3 + '</span>' + $4 + $5 }

    # stylize trademark symbol
    text.gsub!(/\^?\(TM\)/i, "<sup>TM</sup>")
  end

  def content

    text = nil

    if @chapter && @chapter.text then
      text = @chapter.text.dup
    end

    if !text.blank? then

      # use unix line breaks
      text.gsub!(/\r\n/, "\n")

      # strip leading and trailing whitespace and breaks
      text.sub!(/^[\s\n]+/, "")
      text.sub!(/[\s\n]+$/, "")

      @chapter.text_transforms.each do |transform|
      	if !transform.pattern.blank? then
	  regex = Regexp.new(transform.pattern)
	  if regex then
	    text.gsub!(regex, transform.replacement)
	  end
	end
      end

      # strip double line breaks
      if @chapter.double_line_breaks then

        text.gsub!(/\n\n/, "\n")

        # pad dense text with extra space since we stripped them
        text.gsub!(/([^\w\s,]) *\n([A-Z\t\"]| {3,})/) { |match| $1 + "\n\n" + $2 }

        # unwrap lines
        if @chapter.wrapped then
          unwrap!(text)
        end

      else

        # unwrap lines
        if @chapter.wrapped then
          unwrap!(text)
        end

        # pad dense text with extra space
        if @chapter.no_paragraph_spacing then
          text.gsub!(/([^\w\s,]) *\n([A-Z\t\"]| {3,})/) { |match| $1 + "\n\n" + $2 }
        end

      end

      # compact extra whitespace lines
      compact_blank_lines!(text)

      # escape html entities
      text = ERB::Util.html_escape(text)

      # convert text styles into html styles
      stylize!(text)

      # convert line breaks to html breaks
      #text = simple_format(text, {}, :sanitize => false)

    end

    text.html_safe
  end

end
