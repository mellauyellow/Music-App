class UpdateAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :status, :string, null: false
  end
end
