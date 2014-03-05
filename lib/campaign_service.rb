require 'uri'
class CampaignService

	def self.launch_campaign campaign, user_id
		Contact.where("user_id = ? ", user_id).each do |contact|

			url_hash = Digest::MD5.hexdigest("#{contact.phone_number}#{Time.now.to_s}#{campaign.id}")
			optin = CampaignOptIn.create! contact_id: contact.id, campaign_id: campaign.id, request_hash: url_hash, expiry: 1.day.from_now, counter: 0, view_counter: 0, viewed:false

			link = "#{ENV['BASE_URL']}campaigns/#{url_hash}/opt_in"
			puts "Link : #{link}"

			short_link = ShortenService.shorten link
			puts "Short Link : #{short_link}"

			raw_text = campaign.tagline
			raw_text = raw_text.gsub(/{{url}}/, short_link)

			puts raw_text
			SmsService.send_international contact.phone_number, raw_text			
		end
	end

	def self.send_key_visual campaign_opt_in
		url_hash = campaign_opt_in.request_hash
		link = "#{ENV['BASE_URL']}campaigns/#{url_hash}/mms"
		short_link = ShortenService.shorten link
		puts "Short Link : #{short_link}"

		raw_text = campaign_opt_in.campaign.description
		message = raw_text.gsub(/{{url}}/, short_link)

		puts message
		SmsService.send_international campaign_opt_in.contact.phone_number, message		
	end
end