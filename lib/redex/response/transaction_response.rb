module Redex
	module Response
		class TransactionResponse < BaseResponse
			attr_reader :code, :message, :order_id, :created_at, :credit_card_authorization_id, :sequential_id, :transaction_id
			def initialize(httpi_response)
				cleaned_response = BaseResponse.clear(httpi_response)
				@code = cleaned_response[:CodRet].to_i
				@message = cleaned_response[:Msgret]
				@order_id = cleaned_response[:NumPedido]
				response_date_time = cleaned_response[:Data] + cleaned_response[:Hora] + '-03:00'
				@created_at = DateTime.strptime(response_date_time, '%Y%m%d%H:%M:%S%z')
				@credit_card_authorization_id = cleaned_response[:NumAutor]
				@sequential_id = cleaned_response[:NumSqn].to_i
				@transaction_id = cleaned_response[:Tid].to_i
			end
		end
	end
end
