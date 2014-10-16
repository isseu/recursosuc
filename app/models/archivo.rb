class Archivo < ActiveRecord::Base
  has_attached_file :documento, styles: {:thumbnail=> ["300x350#", :jpg]}
  validates_with AttachmentPresenceValidator, :attributes => :documento
  validates_attachment :documento, content_type: { content_type: "application/pdf" }
  validates_with AttachmentSizeValidator, :attributes => :documento, :less_than => 5.megabytes

  belongs_to :user
end
