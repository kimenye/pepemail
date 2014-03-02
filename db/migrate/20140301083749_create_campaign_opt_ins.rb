class CreateCampaignOptIns < ActiveRecord::Migration
  def change
    create_table :campaign_opt_ins do |t|
      t.references :campaign, index: true
      t.references :contact, index: true
      t.string :user_agent
      t.string :cookie_hash
      t.string :ip_address
      t.datetime :expiry
      t.boolean :opted_in

      t.timestamps
    end
  end
end
