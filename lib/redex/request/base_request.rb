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

		def sanitize(field)
			return nil if send(field).nil?
			return "%.2f" % send(field) if [:amount].include?(field)
			return "%02d" % send(field) if [:installments, :card_expiration_month, :origin].include?(field)
			return card_expiration_year_sanitized if [:card_expiration_year].include?(field)
			return send(field) ? "1" : "0" if [:recorrence].include?(field)
			return send(field).to_s if [:order_id, :credit_card_authorization_id, :sequential_id, :transaction_id].include?(field)
			return send(field).strftime("%Y%m%d") if [:transaction_date].include?(field)
			send(field)
		end
	end
end

require 'redex/request/transaction_request'
require 'redex/request/cancel_request'
require 'redex/request/query_request'
