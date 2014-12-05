$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'boletosimples'
require 'pp'

# If you need create users in Boleto Simples
# you can get a access token with app_id and app_secret
# def get_access_token
#   response = RestClient.post 'http://sandbox.boletosimples.com.br/api/v1/oauth2/token', {
#     grant_type: 'client_credentials',
#     client_id: 'app_id',
#     client_secret: 'app_secret'
#   }
#
#   access_app_token = JSON.parse(response)["access_token"]
# end

credentials = {
  token: 'access_app_token'
}

client_options = {
  user_agent: 'Meu e-Commerce (meuecommerce@example.com)'
}

client = BoletoSimples::OAuthClient.new('app_id',
                                        'app_secret',
                                        credentials,
                                        client_options)

# create user with oauth
# pp client.partner_create_user(
#   {
#     user: {
#       email: 'new_user@example.com'
#     }
#   }
# )

# Other operations need access tokens from user oatuh autorization process
# Use our omniauth-boletosimples (https://github.com/BoletoSimples/omniauth-boletosimples) to archive these tokens

credentials = {
  token: 'access token'
}

client_options = {
  user_agent: 'Meu e-Commerce (meuecommerce@example.com)'
}

client = BoletoSimples::OAuthClient.new('app_id',
                                        'app_secret',
                                        credentials,
                                        client_options)

# pp client.userinfo

# pp client.transactions

# pp client.customers

# pp client.customer 2
#
# pp client.create_customer(
#   {
#     person_name: "Joao da Silva",
#     cnpj_cpf: "012.345.678-90",
#     email: "cliente@bom.com",
#     address: "Rua quinhentos",
#     city_name: "Rio de Janeiro",
#     state: "RJ",
#     neighborhood: "bairro",
#     zipcode: "12312-123",
#     address_number: "111",
#     address_complement: "Sala 4",
#     phone_number: "2112123434"
#   }
# )

# pp client.bank_billets

# pp client.bank_billet 3

# pp client.create_bank_billet(
#   {
#     amount: 41.01,
#     customer_address: 'Rua quinhentos',
#     customer_address_complement: 'Sala 4',
#     customer_address_number: '111',
#     customer_city_name: 'Rio de Janeiro',
#     customer_cnpj_cpf: '012.345.678-90',
#     customer_email: 'cliente@bom.com',
#     customer_neighborhood: 'Sao Francisco',
#     customer_person_name: 'Joao da Silva',
#     customer_person_type: 'individual',
#     customer_phone_number: '2112123434',
#     customer_state: 'RJ',
#     customer_zipcode: '12312-123',
#     description: 'Despesas do contrato 0012',
#     expire_at: '2014-01-01',
#     notification_url: 'http://example.com.br/notify',
#   }
# )
