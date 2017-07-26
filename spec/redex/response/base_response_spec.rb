require "spec_helper"

module Redex::Response
  RSpec.describe BaseResponse do
    let(:httpi_result) { {"Cet"=>[{"i:nil"=>"true"}], "CodRet"=>["00"], "Data"=>["20170725"], "Hora"=>["16:22:17"], "Juros"=>[{"i:nil"=>"true"}], "MsgAvs"=>[{"i:nil"=>"true"}], "Msgret"=>["Sucesso"], "NumAutor"=>["135985"], "NumPedido"=>["3"], "NumSqn"=>["110087"], "RespAvs"=>[{"i:nil"=>"true"}], "Tid"=>["25458329533"], "ValParcelas"=>[{"i:nil"=>"true"}], "ValTotalJuros"=>[{"i:nil"=>"true"}]} }

    context 'parseando results' do
      it 'deve remover elementos nulos' do
        expect(BaseResponse.new(httpi_result).raw[:Cet]).to be_nil
      end

      it 'deve remover o array' do
        expect(BaseResponse.new(httpi_result).raw[:CodRet]).to eq "00"
      end
    end
  end
end
