class AddOptInDecidedToCampaignOptIn < ActiveRecord::Migration
  def change
    add_column :campaign_opt_ins, :decided, :boolean, default: false
  end
end
