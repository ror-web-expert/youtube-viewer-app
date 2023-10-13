class HtmlParser

  def initialize(post)
    @post = post
    @job_details = @post.response_data["description_raw_html"]
  end

  def formatted_markdown
    markdown = ReverseMarkdown.convert(@job_details)
    markdown = markdown.gsub("&nbsp;", "")
    raw_html = Kramdown::Document.new(markdown).to_html
    @post.response_data["description_raw_html"] = raw_html
    @post.save
  end
end
