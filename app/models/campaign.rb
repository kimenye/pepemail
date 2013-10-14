class Campaign < ActiveRecord::Base
  belongs_to :item
  attr_accessible :campaign_type, :description, :discount, :end_date, :start_date, :tagline, :target, :item_id
end
