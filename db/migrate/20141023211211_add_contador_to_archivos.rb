class AddContadorToArchivos < ActiveRecord::Migration
  def change
    add_column :archivos, :descargas, :integer, default: 0
  end
end
