require "spec_helper"

module Redex::Request
  RSpec.describe CancelRequest do
    context 'sanitizando parametros' do
      it 'data da transacao deve ser um numérico de 8 digitos' do
        transaction = CancelRequest.new(transaction_date: Date.new(2017, 11, 20))
        expect(transaction.sanitize(:transaction_date)).to eq("20171120")
      end

      it 'número de autorizacao deve ser um numérico' do
        transaction = CancelRequest.new(credit_card_authorization_id: 19283746)
        expect(transaction.sanitize(:credit_card_authorization_id)).to eq("19283746")
      end

      it 'número sequencial deve ser um numérico' do
        transaction = CancelRequest.new(sequential_id: 12345678909)
        expect(transaction.sanitize(:sequential_id)).to eq("12345678909")
      end

      it 'identicação da transação deve ser um numérico' do
        transaction = CancelRequest.new(transaction_id: 1234567890992912)
        expect(transaction.sanitize(:transaction_id)).to eq("1234567890992912")
      end

    end
  end
end
