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

		end
	end
end
