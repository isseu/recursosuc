class Archivo < ActiveRecord::Base
  has_attached_file :documento, styles: {:thumbnail=> ["300x350#", :jpg]}
  validates_with AttachmentPresenceValidator, :attributes => :documento
  validates_attachment :documento, content_type: { content_type: "application/pdf" }
  validates_with AttachmentSizeValidator, :attributes => :documento, :less_than => 5.megabytes
  validates :user_id, presence: true
  validates :ano, presence: true
  validates :semestre, presence: true
  validates :profesor, presence: true
  validates :tipo, presence: true
  validates :curso, presence: true

  belongs_to :user
  belongs_to :curso

  def self.buscar(busqueda)
    condiciones = []
    #sigla = /((\s|^)sigla\:.+?(\s|$))/i.match(busqueda)
    #if not sigla.nil?
    #  conditions.push(["archivo.sigla LIKE ?", "%#{sigla['sigla']}%"])
    #else
    #  nil
    #end
    tipo = /(\s|^)tipo\:(?<tipo>.+?)(\s|$)/i.match(busqueda)
    busqueda
    if not tipo.nil?
      condiciones.push(["archivos.tipo = ?", tipo['tipo']])
    else
      nil
    end
    #condiciones.push(["archivos.documento_file_name LIKE ?", "%#{busqueda}%"])
    Archivo.where(conditions(condiciones))
  end

  private

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
