require "spec_helper"

module Redex::Response
  RSpec.describe TransactionResponse do
    let(:httpi_result) { {"Cet"=>[{"i:nil"=>"true"}], "CodRet"=>["00"], "Data"=>["20170725"], "Hora"=>["16:22:17"], "Juros"=>[{"i:nil"=>"true"}], "MsgAvs"=>[{"i:nil"=>"true"}], "Msgret"=>["Sucesso"], "NumAutor"=>["135985"], "NumPedido"=>["pedido123"], "NumSqn"=>["110087"], "RespAvs"=>[{"i:nil"=>"true"}], "Tid"=>["25458329533"], "ValParcelas"=>[{"i:nil"=>"true"}], "ValTotalJuros"=>[{"i:nil"=>"true"}]} }
    let(:transaction_response) { TransactionResponse.new(httpi_result) }

    it 'deve parsear o código de retorno' do
      expect(transaction_response.code).to eq(0)
    end

    it 'deve parsear mensagem de retorno' do
      expect(transaction_response.message).to eq("Sucesso")
    end

    it 'deve parsear numero do pedido de retorno' do
      expect(transaction_response.order_id).to eq("pedido123")
    end

    it 'deve parsear data de retorno' do
      expect(transaction_response.created_at).to eq(DateTime.new(2017, 07, 25, 16, 22, 17,'-03:00'))
    end
  end
end
