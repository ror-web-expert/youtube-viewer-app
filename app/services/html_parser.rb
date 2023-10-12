class HtmlParser

  # MarkdownEquivalents = {
  #   "p" => "",
  #   "br" => "  \n",  # For line breaks
  #   "h3" => "# ",
  #   "strong" => "**",
  #   "em" => " _",
  #   "u" => "<u>",
  #   "del" => "~~",
  #   "code" => "`",
  #   "ul" => "",  # List items are handled individually
  #   "ol" => "",  # List items are handled individually
  #   "li" => "- ",  # For list items
  #   "blockquote" => "> ",
  #   "pre" => "```\n",  # For code blocks
  # }

  def initialize(post)
    @post = post
    @job_details = @post.response_data["description_raw_html"]
  end

  def formatted_markdown
    @job_details =  @job_details.gsub("\n", "").gsub("\t", "").gsub("\r", "")
    markdown = ReverseMarkdown.convert(@job_details)
    markdown_array = markdown.gsub("&nbsp;", "").split("\n\n")
    result = convert_to_markdown(markdown_array)
    @post.response_data["description_formatted_html"] = result
    @post.save
  end

  def convert_to_markdown(input_array)
    output_array = []
    input_array.each do |line|
      line = line.tr("\n:","").squish
      if line.start_with?(/^[0-9]+\./)
        list = line.split(/^[0-9]+\./)
        output_array << { "ol" => list.map {|l| { "li" => l } if l.present? }.compact! }
      elsif (line =~ /^[A-Za-z0-9]/ )  || ( line.start_with?("_") && line.end_with?("_") )
        output_array << {"p" => line }
      elsif line.start_with?("#") || ( line.start_with?("**") && line.end_with?("**") )
        output_array << { "h3" => line.tr("#*"," ") }
      elsif line.start_with?("-")
        list = line.split("-")
        output_array << { "ul" => list.map {|l| { "li" => l.tr("#*"," ") } if l.present?  }.compact! }
      elsif line.start_with?("`") && line.end_with?("`")
        output_array << { "p" => line.tr("`","") }
      elsif line.start_with?("[")
      elsif line.start_with?("**")
        sections = line.split(/\*{2}(.*?)\*{2}/).map(&:strip).reject(&:empty?)
        output_array << { "h3" => sections[0]}
        output_array << { "p" => sections[1] }
      end
    end
    output_array
  end

end
