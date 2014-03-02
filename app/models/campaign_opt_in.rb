class CampaignOptIn < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :contact

  def is_expired?
  	num = ENV['LINK_ATTEMPTS'].to_i
  	counter > 0 || Time.now > expiry
  end

  def is_consumed?
  	num = ENV['LINK_ATTEMPTS'].to_i
  	decided && viewed && view_counter > 0
  end
end
