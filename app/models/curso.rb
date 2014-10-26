class Curso < ActiveRecord::Base
  has_many :archivos

  def self.buscar(busqueda)
    return Curso.where("cursos.nombre LIKE ? OR cursos.sigla LIKE ?", "%#{busqueda.upcase}%", "%#{busqueda.upcase}%")
  end
end
