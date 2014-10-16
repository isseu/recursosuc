class AddAttachmentDocumentoToArchivos < ActiveRecord::Migration
  def self.up
    change_table :archivos do |t|
      t.attachment :documento
    end
  end

  def self.down
    remove_attachment :archivos, :documento
  end
end
