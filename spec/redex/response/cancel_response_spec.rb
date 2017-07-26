require "spec_helper"

module Redex::Response
  RSpec.describe CancelResponse do
    let(:httpi_result) { {"Cet"=>[{"i:nil"=>"true"}], "CodRet"=>["00"], "Data"=>["20170725"], "Hora"=>["16:22:17"],
    "Juros"=>[{"i:nil"=>"true"}], "Msgret"=>["Sucesso"], "NumSqn"=>["112233"], "RespAvs"=>[{"i:nil"=>"true"}], "Tid"=>["15462083544"]} }

    let(:transaction_response) { CancelResponse.new(httpi_result) }

    it 'deve parsear o código de retorno' do
      expect(transaction_response.code).to eq(0)
    end

    it 'deve parsear mensagem de retorno' do
      expect(transaction_response.message).to eq("Sucesso")
    end

    it 'deve parsear data de retorno' do
      expect(transaction_response.canceled_at).to eq(DateTime.new(2017, 07, 25, 16, 22, 17,'-03:00'))
    end

    it 'deve parsear número sequência da rede' do
      expect(transaction_response.sequential_id).to eq(112233)
    end

    it 'deve parsear identicação da resposta' do
      expect(transaction_response.transaction_id).to eq(15462083544)
    end
  end
end
