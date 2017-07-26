module Redex::Request
	class BaseRequest
		def self.client
    	@client ||= CannedSoap::Client.new(Redex.service_url)
  	end

		def authorization_params
			{
				Filiacao: Redex.secret_pv.to_s,
				Senha: Redex.secret_token.to_s
			}
		end

		def result
			@result ||= do_request
		end
	end
end

require 'redex/request/transaction_request'
