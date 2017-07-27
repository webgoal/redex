module Redex
	module Response
		class QueryResponse < BaseResponse
			attr_reader :canceled_at, :amount, :transaction_type, :installments, :order_id,
				:card_number, :transaction_id, :card_expiration_month, :card_holder_name,
				:invoice_note, :origin, :status, :transaction_created_at, :credit_card_authorization_id,
				:code, :message
			def initialize(httpi_response)
				super(httpi_response[:REGISTRO])
			end

			def amount
				@amount ||= @raw[:TOTAL].to_f
			end

			def transaction_type
				@transaction_type ||= @raw[:TRANSACAO].to_f
			end

			def installments
				@installments ||= @raw[:PARCELAS].to_f
			end

			def order_id
				@order_id ||= @raw[:NUMPEDIDO]
			end

			def card_number
				@card_number ||= @raw[:NR_CARTAO]
			end

			def sequential_id
				@sequential_id ||= @raw[:NUMSQN].to_i
			end

			def card_expiration_month
				@card_expiration_month ||= @raw[:MES].to_i
			end

			def invoice_note
				@invoice_note ||= @raw[:IDENTIFICACAOFATURA]
			end

			def card_holder_name
				@card_holder_name ||= @raw[:NOM_PORTADOR]
			end

			def origin
				@origin ||= @raw[:ORIGEM].to_i
			end

			def status
				@status ||= @raw[:STATUS].to_i
			end

			def code
				@code ||= @raw[:COD_RET].to_i
			end

			def message
				@message ||= @raw[:MSG_RET]
			end

			def credit_card_authorization_id
				@credit_card_authorization_id ||= @raw[:NUMAUTOR].to_i
			end

			def transaction_created_at
				@transaction_created_at ||= datetime_sanitize(@raw[:DATA], @raw[:HORA])
			end

			def transaction_canceled_at
				@transaction_canceled_at ||= datetime_sanitize(@raw[:DATA], "00:00:00")
			end



			def clear(httpi_result)
				httpi_result.delete("AVS")
				httpi_result = Hash[httpi_result.map { |k, v| [k.to_sym, v] }]
				httpi_result.select! {|k,v| v != [{}]}
				httpi_result.each { |k, v| httpi_result[k] = v.first }
			end
		end
	end
end
