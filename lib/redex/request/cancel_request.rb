module Redex
	module Request
		class CancelRequest < BaseRequest
			attr_accessor :transaction_date, :credit_card_authorization_id, :sequential_id, :transaction_id

      def initialize(params = {})
				@transaction_date = params.fetch(:transaction_date, Date.today)
				@credit_card_authorization_id = params[:credit_card_authorization_id]
				@sequential_id = params[:sequential_id]
				@transaction_id = params[:transaction_id]
      end
    end
  end
end
