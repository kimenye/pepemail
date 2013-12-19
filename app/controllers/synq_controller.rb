class SynqController < ApplicationController

	def index
	end

	def create
		SmsService.send_text(params[:phone_number], params[:message])
		respond_to do |format|
			format.html 
    	end
	end
end