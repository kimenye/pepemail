class Campaign < ActiveRecord::Base
  belongs_to :item
  attr_accessible :campaign_type, :description, :discount, :end_date, :start_date, :tagline, :target, :item_id, :background_color, :secondary_color, :hero
  has_attached_file :hero, :styles => { :medium => "600x310>", :thumb => "100x100>" }
end
