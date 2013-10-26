class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :item
      t.string :caption

      t.timestamps
    end
    add_index :photos, :item_id
  end
end
