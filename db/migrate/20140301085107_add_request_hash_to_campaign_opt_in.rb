class AddRequestHashToCampaignOptIn < ActiveRecord::Migration
  def change
    add_column :campaign_opt_ins, :request_hash, :string
  end
end
