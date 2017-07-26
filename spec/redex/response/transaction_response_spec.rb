require "spec_helper"

module Redex::Response
  RSpec.describe TransactionResponse do
    let(:httpi_result) { {"Cet"=>[{"i:nil"=>"true"}], "CodRet"=>["00"], "Data"=>["20170725"], "Hora"=>["16:22:17"],
    "Juros"=>[{"i:nil"=>"true"}], "MsgAvs"=>[{"i:nil"=>"true"}], "Msgret"=>["Sucesso"], "NumAutor"=>["1BC3a4"],
    "NumPedido"=>["pedido123"], "NumSqn"=>["112233"], "RespAvs"=>[{"i:nil"=>"true"}], "Tid"=>["15462083544"],
    "ValParcelas"=>[{"i:nil"=>"true"}], "ValTotalJuros"=>[{"i:nil"=>"true"}]} }

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

    it 'deve parsear numero da autorização da operadora do cartao' do
      expect(transaction_response.credit_card_authorization_id).to eq("1BC3a4")
    end

    it 'deve parsear número sequência da rede' do
      expect(transaction_response.sequential_id).to eq(112233)
    end

    it 'deve parsear identicação da resposta' do
      expect(transaction_response.transaction_id).to eq(15462083544)
    end

    context 'se order_id já for cadastrada' do
      let(:httpi_result) {{"Cet"=>[{"i:nil"=>"true"}], "CodRet"=>["42"], "Data"=>[{"i:nil"=>"true"}], "Hora"=>[{"i:nil"=>"true"}],
      "Juros"=>[{"i:nil"=>"true"}], "MsgAvs"=>[{"i:nil"=>"true"}], "Msgret"=>["Valor enviado no campo NumPedido j\u00E1 existente para o seu estabelecimento"],
      "NumAutor"=>[{"i:nil"=>"true"}], "NumPedido"=>[{"i:nil"=>"true"}], "NumSqn"=>[{"i:nil"=>"true"}], "RespAvs"=>[{"i:nil"=>"true"}], "Tid"=>[{"i:nil"=>"true"}],
      "ValParcelas"=>[{"i:nil"=>"true"}], "ValTotalJuros"=>[{"i:nil"=>"true"}]} }

      let(:message_expected) { "Valor enviado no campo NumPedido já existente para o seu estabelecimento" }

      it 'deve tratar erro na mensagem de retorno' do
        expect{transaction_response}.to_not raise_error
      end

      it 'deve tratar erro na mensagem de retorno' do
        expect(message_expected).to eq (transaction_response.message)
      end
    end
  end
end
