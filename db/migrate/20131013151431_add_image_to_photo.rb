class AddImageToPhoto < ActiveRecord::Migration
  def change
    add_attachment :photos, :image
  end
end
