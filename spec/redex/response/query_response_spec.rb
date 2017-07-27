require "spec_helper"

module Redex::Response
  RSpec.describe QueryResponse do
    let(:httpi_result) { {:HEADER=>{"DATA_REQUISICAO"=>["20170727"], "FILIACAO"=>["50079557"],
      "HORA_REQUISICAO"=>["15:25:06"]},
      :REGISTRO=>{"AVS"=>[{"CEP"=>[{}], "COMPLEMENTO"=>[{}], "CPF"=>[{}], "ENDERECO"=>[{}],
      "MSG_AVS"=>[{}], "NU_ENDERECO"=>[{}], "RESP_AVS"=>[{}]}], "COD_RET"=>["00"],
      "DATA"=>["20170727"], "DATA_CANC"=>["20170727"], "DATA_CON_PRE_AUT"=>[{}],
      "DATA_EXP_PRE_AUT"=>[{}], "FILIACAO_DSTR"=>["0"], "HORA"=>["15:00:01"],
      "IDENTIFICACAOFATURA"=>["Teste-Renovacao"], "MOEDA"=>["Real"],
      "MSG_RET"=>["Sucesso"], "NOM_PORTADOR"=>["Aluanetraiu"],
      "NR_CARTAO"=>["544828XXXXXX0007"], "NUMAUTOR"=>["219947"],
      "NUMPEDIDO"=>["34"], "NUMSQN"=>["90739"], "ORIGEM"=>["1"], "PARCELAS"=>["00"],
      "STATUS"=>["3"], "TAXA_EMBARQUE"=>["0.00"], "TID"=>["123123123123"],
      "TOTAL"=>["5009.00"], "TRANSACAO"=>["4"],
      "_x0033_DS"=>[{"CAVV"=>[{}], "ECI"=>[{}], "XID"=>[{}]}]}} }

    let(:transaction_response) { QueryResponse.new(httpi_result) }

    xit 'deve parsear o valor total da compra' do
      expect(transaction_response.total).to eq(5009)
    end

    xit 'deve parsear o tipo de transacao' do
      expect(transaction_response.transaction_type).to eq(0)
    end

    xit 'deve parsear o numeros de parcelas' do
      expect(transaction_response.installments).to eq(0)
    end

    xit 'deve parsear o numeros pedido gerado pelo estabelecimento' do
      expect(transaction_response.order_id).to eq(0)
    end

    xit 'deve parsear o numero do cartao' do
      expect(transaction_response.card_number).to eq(0)
    end

    xit 'deve parsear o numero sequencia da rede' do
      expect(transaction_response.sequential_id).to eq(0)
    end

    xit 'deve parsear o mês de validade do cartao' do
      expect(transaction_response.card_expiration_month).to eq(0)
    end

    xit 'deve parsear o nome do portador do cartao' do
      expect(transaction_response.card_holder_name).to eq(0)
    end

    xit 'deve parsear a mensagem que sera exibida ao lado do nome do estabelecimento' do
      expect(transaction_response.invoice_note).to eq(0)
    end

    xit 'deve parsear um numero que identifica a origem da transacao' do
      expect(transaction_response.origin).to eq(0)
    end

    xit 'deve parsear data da requisicao de transacao' do
      expect(transaction_response.created_at).to eq(DateTime.new(2017, 07, 25, 16, 22, 17,'-03:00'))
    end

    xit 'deve parsear o status da data hora da requisicao' do
      expect(transaction_response.status).to eq(0)
    end

    xit 'deve parsear data da realizacao da transacao' do
      expect(transaction_response.transaction_created_at).to eq(DateTime.new(2017, 07, 25, 16, 22, 17,'-03:00'))
    end

    xit 'deve parsear data de cancelamento' do
      expect(transaction_response.transaction_canceled_at).to eq(DateTime.new(2017, 07, 25, 16, 22, 17,'-03:00'))
    end

    xit 'deve parsear identicação da resposta' do
      expect(transaction_response.transaction_id).to eq(15462083544)
    end

    xit 'deve parsear numero da autorização da operadora do cartao' do
      expect(transaction_response.credit_card_authorization_id).to eq(123123)
    end

    xit 'deve parsear o código de retorno' do
      expect(transaction_response.code).to eq(0)
    end

    xit 'deve parsear mensagem de retorno' do
      expect(transaction_response.message).to eq("Sucesso")
    end
  end
end
