module Redex::Request
	class BaseRequest
		def self.client
    	@client ||= CannedSoap::Client.new(Redex.service_url)
  	end
	end
end

require 'redex/request/transaction_request'
