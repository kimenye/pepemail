class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.timestamp :start_date
      t.timestamp :end_date
      t.text :tagline
      t.text :description
      t.references :item
      t.decimal :discount
      t.integer :target
      t.string :campaign_type

      t.timestamps
    end
    add_index :campaigns, :item_id
  end
end
