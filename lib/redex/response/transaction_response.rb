module Redex
	module Response
		class TransactionResponse < BaseResponse
			attr_reader :order_id, :created_at, :credit_card_authorization_id

			def order_id
				@order_id ||= @raw[:NumPedido]
			end

			def credit_card_authorization_id
				@credit_card_authorization_id ||= @raw[:NumAutor].to_i
			end

			def created_at
				@created_at ||= datetime_sanitize(@raw[:Data], @raw[:Hora])
			end
		end
	end
end
