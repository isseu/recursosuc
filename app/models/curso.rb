class Curso < ActiveRecord::Base
  validates :nombre, uniqueness: { case_sensitive: false }
  validates :sigla, uniqueness: { case_sensitive: false }
  has_many :archivos

  def self.buscar(busqueda)
    return Curso.where("cursos.nombre LIKE ? OR cursos.sigla LIKE ?", "%#{busqueda.upcase}%", "%#{busqueda.upcase}%")
  end
end
