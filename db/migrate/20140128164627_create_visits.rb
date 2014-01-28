class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
    	t.belongs_to :contact
    	t.belongs_to :url
    	t.integer :counter
    	t.string :url_hash
    end
  end
end
