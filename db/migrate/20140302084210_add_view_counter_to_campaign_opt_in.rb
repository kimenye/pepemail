class AddViewCounterToCampaignOptIn < ActiveRecord::Migration
  def change
    add_column :campaign_opt_ins, :view_counter, :integer
    add_column :campaign_opt_ins, :viewed, :boolean
  end
end
