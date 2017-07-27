module Redex
	module Request
		class CancelRequest < BaseRequest
			attr_accessor :transaction_date, :credit_card_authorization_id, :sequential_id, :transaction_id

      def initialize(params = {})
				@transaction_date = params[:transaction_date]
				@credit_card_authorization_id = params[:credit_card_authorization_id]
				@sequential_id = params[:sequential_id]
				@transaction_id = params[:transaction_id]
      end

			def sanitized_fields
				{
					Data: sanitize(:transaction_date),
					NumAutor: sanitize(:credit_card_authorization_id),
					NumSqn: sanitize(:sequential_id),
					Tid: sanitize(:transaction_id)
				}.merge(authorization_params).sort.to_h.select { |k, v| !v.to_s.empty?  }
			end

			private
			def do_request
				raw_response = BaseRequest.client.VoidTransactionTID(request: sanitized_fields)
				Redex::Response::CancelResponse.new(raw_response.result)
			end
    end
  end
end
