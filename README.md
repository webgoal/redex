# Redex

Uma refatoração da gem de integração para o sistema de pagamentos [eRede](https://www.userede.com.br/nossos-produtos/e-rede/)

O objetivo desta gem é normalizar nomes de campos, permitir o uso de classes do ruby na chamada serviços e mascarar a comunicação com um servidor SOAP (utilizando a gem [canned_soap](http://github.com/gknedo/canned_soap))

## Funcionalidades
Resumo das operações suportadas pelo Redex.

### Transações de Crédito

Todas as transações com autorização (captura) automática são suportadas. Apesar de transações de pré-autorização (sem captura) automática serem suportadas, a trasanção de captura ainda não foi desenvolvida.

### Cancelamento

O cancelamento de transações de crédito são suportadas, mas assim como o serviço SOAP da eRede elas devem ser feitas no mesmo dia da captura. Transações de pré-autorização são suportadas e podem ser canceladas em até 29 dias da pré-autorização, após esse período elas são canceladas automaticamente

### Consulta

Consultas são suportadas.

## Funcionalidades não desenvolvidas ou em desenvolvimento

### Transações Autenticadas (3D Security)

Transações autenticadas, seja de débito ou crédito, ainda não são suportadas.


## Instalação

Adicione esta linha no seu Gemfile:

```ruby
gem 'redex'
```

Então execute:

    $ bundle

Para instalar sem o bundle:

    $ gem install redex

## Utilização

### Guia Rápido

Todas as requisições suportadas são utilizadas via sua respectiva classe, que ficam dentro do modulo `Redex::Request`, elas são inicializadas como um objeto padrão do ruby e são executadas ao chamar o método `result` e retornaram objetos do tipo response, que são do módulo `Redex::Response`.

*Objetos do tipo Request executam o request somente na primeira chamada do método result!*

Exemplo de uso:

```ruby
request = Redex::Request::QueryRequest.new(transaction: 123456789)
response = request.result #Redex::Response::QueryResponse
response.credit_card_authorization_id
```
### Configuração

Antes de iniciar, é necessário configurar a autorização e a URL do servidor. Esta configuração pode ser sobrescrita em qualquer lugar do seu código.

```ruby
Redex.configuration do |config|
  config.secret_pv = 123456789 # Seu Numero de Filiacao
  config.secret_token = "1a2b3c4d5f6f7g8h90" # Sua senha
  config.service_url = 'https://scommerce.userede.com.br/example'
end
```

Por padrão o `service_url` vem configurado com o ambiente de testes do eRede.

### Transação de Crédito

Requests são feitas utilizando a classe `Redex::Request::TransactionRequest`.

| Redex | Tipo do Campo | Equivalente SOAP | Observações |
| --- | --- | --- | --- |
| order_id | String | NUMPEDIDO |
| amount | Integer ou Float | TOTAL
| card_number | Integer ou String | NRCARTAO |
| card_holder_name | String | PORTADOR |
| card_cvc | Integer ou String | CVC2 |
| card_expiration_month | Integer ou String | MÊS
| card_expiration_year | Integer ou String | ANO
| installments | Integer ou String | PARCELAS | Padrão: 1
| recorrence | Boolean | RECORRENTE | Padrão: false
| | | ORIGEM | Sempre será 01 (eRede)
| | | TRANSACAO | Calculado pela gem


## Desenvolvimento

Após clonar o repositório, execute `bin/setup` para instalar as dependências. Para rodar os testes execute `rake spec`. Você também pode executar `bin/console` para um console interativo.

Para instalar essa gem na sua máquina local execute `bundle exec rake install`. Para gerar uma nova versão atualize o arquivo `version.rb` e então execute `bundle exec rake release`, isto irá criar uma tag do git para a versão, faça o commit e o push do repositório, e então envie o arquivo `.gem` para [rubygems.org](https://rubygems.org).

## Contribua

Bug reports e pull requests são bem vindos no nosso GitHub at https://github.com/gknedo/redex. Este projeto visa ser um lugar seguro e receptivo para novos colaborados e é esperado que os contribuidores sigam o [Código de Conduta](http://contributor-covenant.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
