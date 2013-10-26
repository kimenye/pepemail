class AddBottomPatternToCampaign < ActiveRecord::Migration
  def change
  	add_attachment :campaigns, :bottom 
  end
end
