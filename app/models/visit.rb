class Visit < ActiveRecord::Base
	belongs_to :contact
	belongs_to :url

	def is_expired?
		counter > url.num_clicks
	end
end