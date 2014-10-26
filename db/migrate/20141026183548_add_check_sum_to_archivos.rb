class AddCheckSumToArchivos < ActiveRecord::Migration
  def self.up
    add_column :archivos, :documento_fingerprint, :string
  end

  def self.down
    remove_column :archivos, :documento_fingerprint
  end
end
