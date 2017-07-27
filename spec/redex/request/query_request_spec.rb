require "spec_helper"

module Redex::Request
  RSpec.describe QueryRequest do
    context 'sanitizando parametros' do
      it 'numero do pedido deve ser um alfanumerico' do
        transaction = QueryRequest.new(order_id: "312312312ABO")
        expect(transaction.sanitize(:order_id)).to eq("312312312ABO")
      end

      it 'identificacao da transacao deve ser um numérico' do
        transaction = QueryRequest.new(transaction_id: 12345678909876543212)
        expect(transaction.sanitize(:transaction_id)).to eq("12345678909876543212")
      end
    end
  end
end
