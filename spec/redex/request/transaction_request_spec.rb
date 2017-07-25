require "spec_helper"

module Redex::Request
  RSpec.describe TransactionRequest do
    context 'sanitizando parametros' do
      it 'order_id deve ser uma string' do
        transaction = TransactionRequest.new(order_id: 101)
        expect(transaction.order_id_sanitized).to eq("101")
      end

      it 'amount deve ser uma string com dois zeros a direita' do
        transaction = TransactionRequest.new(amount: 10)
        expect(transaction.amount_sanitized).to eq("10.00")
      end

      it 'installments deve ser uma string com 2 caracteres' do
        transaction = TransactionRequest.new(installments: 8)
        expect(transaction.installments_sanitized).to eq("08")
      end

      it 'installments deve ser uma string com 2 caracteres' do
        transaction = TransactionRequest.new(installments: 12)
        expect(transaction.installments_sanitized).to eq("12")
      end

      it 'card_expiration_month deve ser uma string com 2 caracteres' do
        transaction = TransactionRequest.new(card_expiration_month: 8)
        expect(transaction.card_expiration_month_sanitized).to eq("08")
      end

      it 'card_expiration_month deve ser uma string com 2 caracteres' do
        transaction = TransactionRequest.new(card_expiration_month: 12)
        expect(transaction.card_expiration_month_sanitized).to eq("12")
      end

      it 'card_expiration_year deve ser uma string com 4 caracteres' do
        transaction = TransactionRequest.new(card_expiration_year: 2018)
        expect(transaction.card_expiration_year_sanitized).to eq("2018")
      end

      it 'card_expiration_year deve ser uma string com 4 caracteres' do
        transaction = TransactionRequest.new(card_expiration_year: 18)
        expect(transaction.card_expiration_year_sanitized).to eq("2018")
      end

      it 'origin_sanitized deve ser o código do eRede' do
        transaction = TransactionRequest.new()
        expect(transaction.origin_sanitized).to eq("01")
      end

      describe 'transaction_id' do
        context 'sem captura automática' do
          it 'o transaction_type deve ser 74' do
            transaction = TransactionRequest.new()
            expect(transaction.transaction_type).to eq("74")
          end
        end
        context 'com captura automática' do
          context 'a vista' do
            it 'o transaction_type deve ser 04' do
              transaction = TransactionRequest.new(auto_capture: true, installments: 1)
              expect(transaction.transaction_type).to eq("04")
            end
          end
          context 'parcelado' do
            it 'o transaction_type deve ser 08' do
              transaction = TransactionRequest.new(auto_capture: true, installments: 3)
              expect(transaction.transaction_type).to eq("08")
            end
          end
        end
      end

    end
  end
end
