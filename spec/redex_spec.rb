require "spec_helper"

RSpec.describe Redex do
  it "has a version number" do
    expect(Redex::VERSION).not_to be nil
  end

  it 'deve inicializar com os parametros passados' do
    request = Redex::Request::TransactionRequest.new(order_id: 1, amount: 500)
    expect(request.order_id).to eq(1)
    expect(request.amount).to eq(500)
  end
end
