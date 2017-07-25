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
				@auto_capture = params[:auto_capture]
	      @recorrence = false
	      @origin = 1
	    end

			def run
				raw_response = BaseRequest.client.GetAuthorizedCredit(request: sanitized_fields)
				return Redex::Response::TransactionResponse(raw_response.result)
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
				}.merge(authorization_params).sort.to_h
			end

			def sanitize(field)
				return send(field).to_s if [:order_id].include?(field)
				return "%.2f" % send(field) if [:amount].include?(field)
				return "%02d" % send(field) if [:installments, :card_expiration_month, :origin].include?(field)
				return card_expiration_year_sanitized if [:card_expiration_year].include?(field)
				return field ? 1 : 0 if [:recorrence].include?(field)
				send(field)
			end

			private

			def transaction_type
				return "74" unless @auto_capture
				return "08" if installments > 1
				"04"
			end

			def card_expiration_year_sanitized
				year = card_expiration_year
				year += 2000 if year < 100
				year.to_s
			end
		end
	end
end
