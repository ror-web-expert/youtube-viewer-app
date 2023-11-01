module ApplicationHelper

  def extract_salary_range(salary_text)
    pattern = /\$(?:\d{1,3}(?:,\d{3})*(?:\.\d{2})?|\d+(?:\.\d{2})?)\s*-\s*\$(?:\d{1,3}(?:,\d{3})*(?:\.\d{2})?|\d+(?:\.\d{2})?)(?:\s*\/\s*(?:hour|year)s?)?/
    matches = salary_text.scan(pattern)
    matches.empty? ? nil : matches[0].strip
  end

  def get_salary_range(salary_string)
    get_salary_rang = extract_salary_range(salary_string)
    get_salary_rang.present? ? get_salary_rang : salary_string
  end

  def formatted_time_ago(created_at)
    time_difference = Time.now - created_at
    if time_difference < 1.day
      "#{(time_difference / 1.hour).to_i}h ago"
    else
      created_at.strftime("%b %d")
    end
  end

  def render_html_content(data)
    if data.present?
    html = data.map do |tag|
      tag.map do |tag_name, tag_content|
        send("render_#{tag_name}", tag_content)
      end.join.html_safe
    end.join.html_safe

    raw(html)
    end
  end

  def render_h3(tag_content)
    content_tag(:h3, tag_content, class: 'text-xl font-bold text-gray-800 mb-3')
  end

  def render_p(tag_content)
    content_tag(:p, tag_content, class: 'text-gray-500 space-y-3')
  end

  def render_ul(tag_content)
    content_tag(:ul, class: 'list-disc list-inside space-y-3') do
      tag_content.map do |li_content|
        render_li(li_content["li"])
      end.join.html_safe
    end
  end

  def render_li(tag_content)
    content_tag(:li, tag_content)
  end

  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      type = 'info' if type == 'info'
      text = "<script>toastr.#{type}('#{message}', '', { closeButton: true, progressBar: true })</script>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end

end
