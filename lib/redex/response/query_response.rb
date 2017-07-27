module Redex
	module Response
		class QueryResponse < BaseResponse
			attr_reader :canceled_at
			def initialize(httpi_response)
				super(httpi_response)
			end
		end
	end
end
