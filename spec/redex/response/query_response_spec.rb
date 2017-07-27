require "spec_helper"

module Redex::Response
  RSpec.describe QueryResponse do
    let(:httpi_result) { {"HEADER"=>[{"DATA_REQUISICAO"=>["20170727"],
      "FILIACAO"=>[{"i:nil"=>"true"}], "HORA_REQUISICAO"=>["17:14:46"]}],
      "REGISTRO"=>[{"AVS"=>[{"CEP"=>[{"i:nil"=>"true"}],
      "COMPLEMENTO"=>[{"i:nil"=>"true"}], "CPF"=>[{"i:nil"=>"true"}],
      "ENDERECO"=>[{"i:nil"=>"true"}], "MSG_AVS"=>[{"i:nil"=>"true"}],
      "NU_ENDERECO"=>[{"i:nil"=>"true"}], "RESP_AVS"=>[{"i:nil"=>"true"}]}],
      "COD_RET"=>["26"], "DATA"=>[{"i:nil"=>"true"}], "DATA_CANC"=>[{"i:nil"=>"true"}],
      "DATA_CON_PRE_AUT"=>[{"i:nil"=>"true"}], "DATA_EXP_PRE_AUT"=>[{"i:nil"=>"true"}],
      "FILIACAO_DSTR"=>[{"i:nil"=>"true"}], "HORA"=>[{"i:nil"=>"true"}],
      "IDENTIFICACAOFATURA"=>[{"i:nil"=>"true"}], "MOEDA"=>[{"i:nil"=>"true"}],
      "MSG_RET"=>["Campo Filiacao ausente"], "NOM_PORTADOR"=>[{"i:nil"=>"true"}],
      "NR_CARTAO"=>[{"i:nil"=>"true"}], "NUMAUTOR"=>[{"i:nil"=>"true"}],
      "NUMPEDIDO"=>[{"i:nil"=>"true"}], "NUMSQN"=>[{"i:nil"=>"true"}],
      "ORIGEM"=>[{"i:nil"=>"true"}], "PARCELAS"=>[{"i:nil"=>"true"}],
      "STATUS"=>[{"i:nil"=>"true"}], "TAXA_EMBARQUE"=>[{"i:nil"=>"true"}],
      "TID"=>[{"i:nil"=>"true"}], "TOTAL"=>[{"i:nil"=>"true"}],
      "TRANSACAO"=>[{"i:nil"=>"true"}], "_x0033_DS"=>[{"CAVV"=>[{"i:nil"=>"true"}],
      "ECI"=>[{"i:nil"=>"true"}], "XID"=>[{"i:nil"=>"true"}]}]}]} }

    let(:transaction_response) { QueryResponse.new(httpi_result) }

    it 'deve parsear o valor total da compra' do
      expect(transaction_response.amount).to eq(5009)
    end

    it 'deve parsear o tipo de transacao' do
      expect(transaction_response.transaction_type).to eq(4)
    end

    it 'deve parsear o numeros de parcelas' do
      expect(transaction_response.installments).to eq(7)
    end

    it 'deve parsear o numeros pedido gerado pelo estabelecimento' do
      expect(transaction_response.order_id).to eq("a123123")
    end

    it 'deve parsear o numero do cartao' do
      expect(transaction_response.card_number).to eq("544828XXXXXX0007")
    end

    it 'deve parsear o numero sequencia da rede' do
      expect(transaction_response.sequential_id).to eq(90739)
    end

    it 'deve parsear o mês de validade do cartao' do
      expect(transaction_response.card_expiration_month).to eq(3)
    end

    it 'deve parsear o nome do portador do cartao' do
      expect(transaction_response.card_holder_name).to eq("Aluanetraiu")
    end

    it 'deve parsear a mensagem que sera exibida ao lado do nome do estabelecimento' do
      expect(transaction_response.invoice_note).to eq("Teste-Renovacao")
    end

    it 'deve parsear um numero que identifica a origem da transacao' do
      expect(transaction_response.origin).to eq(1)
    end

    it 'deve parsear o status' do
      expect(transaction_response.status).to eq(3)
    end

    it 'deve parsear data da realizacao da transacao' do
      expect(transaction_response.transaction_created_at).to eq(DateTime.new(2017, 07, 27, 15, 00, 01,'-03:00'))
    end

    it 'deve parsear data de cancelamento' do
      expect(transaction_response.transaction_canceled_at).to eq(DateTime.new(2017, 07, 27, 0, 0, 0, '-03:00'))
    end

    it 'deve parsear numero da autorização da operadora do cartao' do
      expect(transaction_response.credit_card_authorization_id).to eq(219947)
    end

    it 'deve parsear o código de retorno' do
      expect(transaction_response.code).to eq(0)
    end

    it 'deve parsear mensagem de retorno' do
      expect(transaction_response.message).to eq("Sucesso")
    end
  end
end
