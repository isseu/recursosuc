class Archivo < ActiveRecord::Base
  has_attached_file :documento, styles: {:thumbnail=> ["300x350#", :jpg]}, convert_options: {
      :all => '-background white -flatten +matte -quality 100'
  }
  validates_with AttachmentPresenceValidator, :attributes => :documento
  validates_attachment :documento, content_type: { content_type: "application/pdf" }
  validates_with AttachmentSizeValidator, :attributes => :documento, :less_than => 5.megabytes
  validates :user_id, presence: true
  validates :ano, presence: true
  validates :semestre, presence: true
  validates :profesor, presence: true, length: { minimum: 5, too_long: "Nombre de profesor muy corto" }
  validates :tipo, presence: true
  validates :curso, presence: true

  belongs_to :user
  belongs_to :curso

  def self.buscar(busqueda)
    condiciones = []
    sigla = /(\s|^)sigla\:(?<sigla>.+?)(\s|$)/i.match(busqueda)
    if not sigla.nil?
      curso = Curso.where( ["cursos.sigla = ?", "%#{sigla['sigla'].upcase}" ]).first()
      if not curso.nil?
        condiciones.push(["archivos.curso_id = ?", curso.id])
      end
    else
      nil
    end
    tipo = /(\s|^)tipo\:(?<tipo>.+?)(\s|$)/i.match(busqueda)
    if not tipo.nil?
      condiciones.push(["archivos.tipo = ?", string2tipo(tipo['tipo'])])
    else
      nil
    end
    profesor = /(\s|^)profesor\:"?(?<profesor>.+?)"?(\s|$)/i.match(busqueda)
    if not profesor.nil?
      condiciones.push(["archivos.profesor = ?", profesor['profesor']])
    else
      nil
    end
    #condiciones.push(["archivos.documento_file_name LIKE ?", "%#{busqueda}%"])
    return Archivo.where(conditions(condiciones)).order(ano: :desc, semestre: :desc)
  end

  private
    def self.string2tipo(string)
      case string
        when "I1"
          return 0
        when "I2"
          return 1
        when "I3"
          return 2
        when "Control"
          return 3
        when "Ayudantia"
          return 4
        when "Examen"
          return 5
        else
          return 6
      end
    end

    def self.conditions(condiciones)
      [conditions_clauses(condiciones).join(' AND '), *conditions_options(condiciones)]
    end

    def self.conditions_clauses(condiciones)
      condiciones.map { |condition| condition.first }
    end

    def self.conditions_options(condiciones)
      condiciones.map { |condition| condition[1..-1] }.flatten
    end
end
