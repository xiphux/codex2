module ChaptersHelper

  def compact_blank_lines(text)
    text.gsub(/([^\n])(\n\s*){2,}\n(\s*[^\n])/, "\1\n\n\3")
  end

  def unwrap(text)
    lines = compact_blank_lines(text).split("\n")

    line_count = lines.count

    character_count = 0
    indented_line_count = 0
    space_ended_line_count = 0
    content_line_count = 0

    lines.each do |line|
      spaced_line = line.sub(/^ {2,}([^ ].*)$/, "\t\1")

      indented_line_count += 1 if spaced_line =~ /^\t/

      space_ended_line_count += 1 if spaced_line =~ / $/

      character_count += spaced_line.length

      content_line_count += 1 if !spaced_line.strip.empty?
    end

    average_length = (character_count / content_line_count).to_i

    space_to_line_ratio = space_ended_line_count / content_line_count

    unwrapped_text = text

    if space_to_line_ratio > 0.6 && space_to_line_ratio < 0.98 then
      # text has lots of lines that end in spaces
      # might be unwrappable by using the ending space
      # as an indication of text continuing on the next line
      unwrapped_text = text.gsub(/ \n/, " ")
    elsif (indented_line_count / content_line_count) > 0.20 then
      # text appears to have a number of indented lines
      # try to use indents to find paragraphs
      unwrapped_text = text.gsub(/ *\n(\S)/, " \1")
    elsif (((line_count - content_line_count) / line_count) > 0.10) then
      # text appears to have a number of blank lines
      # try to use blank lines to find paragraphs
      unwrapped_text = text.gsub(/([^\n]) *\n([^\r\s])/, "\1 \2")
    elsif (average_length > 1) then
      # try to unwrap by guessing the width of lines
      regex = Regexp.new("([^\n]{" + average_length.to_i.to_s + ",})\n")
      unwrapped_text = text.gsub(regex) { |match| $1 }
      unwrapped_text = unwrapped_text.gsub(/([\w,]) {2,}([\w,])/, "\1 \2")
    end

    unwrapped_text
  end

  def stylize(text)
    stylized = text.dup

    # stylize breaking lines
    stylized.gsub!(/\s*\n([\s\n])*(([\*\-=\~_<>]) ?){2,}([\s\n])*\n/, "<div class=\"breakline\"></div>")

    # stylize underscore emphasis
    stylized.gsub!(/(\W)_(\S+?)_(\W)/) { |match| $1 + '<span class="emphasis">' + $2 + '</span>' + $3 }

    # stylize asterisk emphasis
    stylized.gsub!(/([^\*])(\*{1,2})([^\*>\n]*)(\*{1,2})([^\*])/) { |match| $1 + $2 + '<span class="emphasis">' + $3 + '</span>' + $4 + $5 }

    # stylize trademark symbol
    stylized.gsub!(/\^?\(TM\)/i, "<sup>TM</sup>")

    stylized
  end

  def format_text(text, options = {})
    return if text.blank?

    formatted = text.dup

    # use unix line breaks
    formatted.gsub!(/\r\n/, "\n")

    # unwrap lines
    if options[:unwrap] == true then
      formatted = unwrap(formatted)
    end

    # pad dense text with extra space
    if options[:padlines] == true then
      formatted.gsub!(/([^\w\s,]) *\n([A-Z\t\"]| {3,})/, "\1\n\n\2")
    end

    # compact extra whitespace lines
    formatted = compact_blank_lines(formatted)

    # convert text styles into html styles
    formatted = stylize(formatted)

    # sanitize html excluding stylized tags
    formatted = sanitize(formatted, :tags => %w(div span sup))

    # convert line breaks to html breaks
    formatted = simple_format(formatted, {}, :sanitize => false)

    # return flagged as html safe
    formatted.html_safe
  end

end
