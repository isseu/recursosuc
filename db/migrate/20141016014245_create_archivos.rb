class CreateArchivos < ActiveRecord::Migration
  def change
    create_table :archivos do |t|
      t.references :user, index: true
      t.string :nombre
      t.string :extension

      t.timestamps
    end
  end
end
