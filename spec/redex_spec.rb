require "spec_helper"

RSpec.describe Redex do
  it "has a version number" do
    expect(Redex::VERSION).not_to be nil
  end

  it 'deve inicializar com os parâmetros passados' do
    request = Redex::Request::TransactionRequest.new(order_id: 1, amount: 500)
    expect(request.order_id).to eq(1)
    expect(request.amount).to eq(500)
  end

  describe 'recorrencia' do
    it 'não deve suportar' do
      request = Redex::Request::TransactionRequest.new(order_id: 1, amount: 500)
      expect(request.recorrence).to eq(false)
    end
  end

  describe 'origigem' do
    it 'deve ser eRede' do
      request = Redex::Request::TransactionRequest.new(order_id: 1, amount: 500)
      expect(request.origin).to eq(1)
    end
  end

  describe 'installments' do
    context 'se passado como parâmetro' do
      it 'deve ser inicializado com o valor passo' do
        request = Redex::Request::TransactionRequest.new(order_id: 1, installments: 4)
        expect(request.installments).to eq(4)
      end
    end

    context 'se não passado como paarâmetro' do
      it 'deve ser inicializado como a vista' do
        request = Redex::Request::TransactionRequest.new(order_id: 1)
        expect(request.installments).to eq(1)
      end
    end
  end
end
