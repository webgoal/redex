module Redex
	module Response
		class BaseResponse
			attr_reader :raw_response

			def self.clear(httpi_result)
				httpi_result = Hash[httpi_result.map { |k, v| [k.to_sym, v] }]
				httpi_result.select! {|k,v| v != [{"i:nil"=>"true"}]}
				httpi_result.each { |k, v| httpi_result[k] = v.first }
			end
		end
	end
end

require 'redex/response/transaction_response'
require 'redex/response/cancel_response'
