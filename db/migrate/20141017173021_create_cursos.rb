class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :nombre
      t.string :sigla

      t.timestamps
    end
  end
end
