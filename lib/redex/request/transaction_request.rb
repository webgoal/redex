module Redex
	module Request
		class TransactionRequest < BaseRequest
			attr_accessor :order_id, :amount, :installments, :invoice_note,
										:card_number, :card_cvc, :card_holder_name,
										:card_expiration_month, :card_expiration_year,
										:auto_capture
			attr_reader :recorrence, :origin

	    def initialize(params = {})
				@order_id = params[:order_id]
				@amount = params[:amount]
				@installments = params.fetch(:installments, 1)
				@invoice_note = params[:invoice_note]
				@card_number = params[:card_number]
				@card_cvc = params[:card_cvc]
				@card_holder_name = params[:card_holder_name]
				@card_expiration_month = params[:card_expiration_month]
				@card_expiration_year = params[:card_expiration_year]
				@auto_capture = params.fetch(:auto_capture, true)
	      @recorrence = params.fetch(:recorrence, false)
	      @origin = 1
	    end

			def sanitized_fields
				{
					NumPedido: sanitize(:order_id),
					Total: sanitize(:amount),
					Parcelas: sanitize(:installments),
					IdentificacaoFatura: sanitize(:invoice_note),
					Nrcartao: sanitize(:card_number),
					Cvc2: sanitize(:card_cvc),
					Portador: sanitize(:card_holder_name),
					Mes: sanitize(:card_expiration_month),
					Ano: sanitize(:card_expiration_year),
					Recorrente: sanitize(:recorrence),
					Origem: sanitize(:origin),
					Transacao: transaction_type
				}.merge(authorization_params).sort.to_h.select { |k, v| !v.to_s.empty?  }
			end

			private

			def do_request
				raw_response = BaseRequest.client.GetAuthorizedCredit(request: sanitized_fields)
				Redex::Response::TransactionResponse.new(raw_response.result)
			end

			def transaction_type
				return "74" unless @auto_capture
				return "08" if installments > 1
				"04"
			end

			def card_expiration_year_sanitized
				year = card_expiration_year.to_i
				year += 2000 if year < 100
				year.to_s
			end
		end
	end
end
