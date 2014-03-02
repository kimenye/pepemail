class AddCounterToCampaignOptIn < ActiveRecord::Migration
  def change
    add_column :campaign_opt_ins, :counter, :integer
  end
end
