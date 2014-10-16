class AddMetadataToArchivos < ActiveRecord::Migration
  def change
    add_column :archivos, :titulo, :string
    add_column :archivos, :descripcion, :text
  end
end
