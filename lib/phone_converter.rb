require 'ext/string'

class PhoneConverter

	def self.is_valid? number
		normalized = PhoneConverter.normalize number
		!normalized.nil? && normalized.length == 12 && normalized.start_with?("2547") && !normalized[/\D/]
	end

	def self.convert number
		if PhoneConverter.is_valid?(number)
			return PhoneConverter.normalize(number)
		else
			return nil
		end
	end


	def self.normalize number
		if !number.nil?
			number = number.wstrip 
			if number.start_with?("07")
				number = "254#{number[1..number.length]}"
			elsif number.start_with?("7")
				number = "254#{number}"
			elsif number.start_with?("+")
				number = number[1..number.length]
			end
			number
		end
	end
end