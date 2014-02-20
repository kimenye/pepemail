class VisitsController < ApplicationController
	layout "mobile"
	has_mobile_fu false

	def show
		@visit = Visit.find_by_url_hash(params[:id])
		@visit.counter = @visit.counter + 1
		@visit.save!
	end
end