module Redex
	module Response
		class CancelResponse < BaseResponse
			attr_reader :canceled_at
			def initialize(httpi_response)
				super(httpi_response)
			end

			def canceled_at
				@canceled_at ||= datetime_sanitize(@raw[:Data], @raw[:Hora])
			end
		end
	end
end
