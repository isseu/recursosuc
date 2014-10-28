module ApplicationHelper
  def full_title(page_title)
    base_title = "Recursos UC"
    if page_title.empty?
      "#{base_title} | Todo el material para los estudiantes UC"
    else
      "#{base_title} | #{page_title}"
    end
  end
  def int2tipo(tipo)
    case tipo
      when 0
        return "Interrogación 1"
      when 1
        return "Interrogación 2"
      when 2
        return "Interrogación 3"
      when 4
        return "Ayudantia"
      else
        return "Otro"
    end
  end
  def int2semestre(sem)
    case sem
      when 0
        return "1er semestre"
      when 1
        return "2do semestre"
      when 2
        return "3er semestre"
      when 3
        return "TAV"
    end
  end
  def quitararrobauc(string)
    if string == "ejcorrea@uc.cl"
      return "admin"
    end
    return string.gsub("@uc.cl", "").gsub("@puc.cl", "")
  end
end
