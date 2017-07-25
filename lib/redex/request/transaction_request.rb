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
				BaseRequest.client.GetAuthorizedCredit(sanitized_params)
			end

			def sanitized_params
				{
					NumPedido: order_id_sanitized,
					Total: amount_sanitized,
					Parcelas: installments_sanitized,
					IdentificacaoFatura: invoice_note_sanitized,
					Nrcartao: card_number_sanitized,
					Cvc2: card_cvc_sanitized,
					Portador: card_holder_name_sanitized,
					Mes: card_expiration_month_sanitized,
					Ano: card_expiration_year_sanitized,
					Recorrente: recorrence_sanitized,
					Origem: origin_sanitized,
					Transacao: transaction_type
				}
			end

			def order_id_sanitized
				order_id.to_s
			end

			def amount_sanitized
				"%.2f" % amount
			end

			def installments_sanitized
				"%02d" % installments
			end

			def card_expiration_month_sanitized
				"%02d" % card_expiration_month
			end

			def card_expiration_year_sanitized
				year = card_expiration_year
				year += 2000 if year < 100
				year.to_s
			end

			def origin_sanitized
				"%02d" % origin
			end

			def transaction_type
				return "74" unless @auto_capture
				return "08" if installments > 1
				"04"
			end
		end
	end
end
