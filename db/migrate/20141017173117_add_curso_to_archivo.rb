class AddCursoToArchivo < ActiveRecord::Migration
  def change
    add_reference :archivos, :curso, index: true
  end
end
