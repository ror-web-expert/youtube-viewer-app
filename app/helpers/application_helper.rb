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

end
