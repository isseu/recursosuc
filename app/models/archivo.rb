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
end
