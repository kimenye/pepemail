class ShortenService
	def self.shorten link
		auth = UrlShortener::Authorize.new ENV['BITLY_USERNAME'], ENV['BITLY_PASSWORD']
        client = UrlShortener::Client.new auth
        result = client.shorten(link)
        shortened_url = result.result['nodeKeyVal']['shortUrl']
        shortened_url		
	end
end