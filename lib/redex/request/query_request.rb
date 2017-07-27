module Redex
	module Request
		class QueryRequest < BaseRequest
			attr_accessor :order_id, :transaction_id

      def initialize(params = {})
				@order_id = params[:order_id]
				@transaction_id = params[:transaction_id]
      end

			def sanitized_fields
				{
          NumPedido: sanitize(:order_id),
          Tid: sanitize(:transaction_id),
				}.merge(authorization_params).sort.to_h.select { |k, v| !v.to_s.empty?  }
			end

			private
			def do_request
				raw_response = BaseRequest.client.Query(request: sanitized_fields)
				Redex::Response::QueryResponse.new(raw_response.result)
			end
    end
  end
end
