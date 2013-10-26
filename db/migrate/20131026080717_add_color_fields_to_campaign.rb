class AddColorFieldsToCampaign < ActiveRecord::Migration
  def change
  	add_column :campaigns, :background_color, :string
  	add_column :campaigns, :secondary_color, :string
  	add_attachment :campaigns, :hero 
  end
end
