class AddMetaToArchivos < ActiveRecord::Migration
  def change
    add_column :archivos, :profesor, :string
    add_column :archivos, :semestre, :integer
    add_column :archivos, :ano, :integer
    add_column :archivos, :tipo, :integer
    add_column :archivos, :curso, :string
  end
end
