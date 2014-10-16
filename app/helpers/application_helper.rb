module ApplicationHelper
  def full_title(page_title)
    base_title = "Recursos UC"
    if page_title.empty?
      "#{base_title} | Todo el material para los estudiantes UC"
    else
      "#{base_title} | #{page_title}"
    end
  end
end
