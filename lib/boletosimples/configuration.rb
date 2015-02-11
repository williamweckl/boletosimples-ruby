# encoding: utf-8
module BoletoSimples

  class Configuration
    attr_accessor :environment, :application_id, :application_secret, :access_token


    BASE_URI = {
      sandbox: 'https://sandbox.boletosimples.com.br/api/v1',
      production: 'https://boletosimples.com.br/api/v1'
    }

    def initialize
      @environment = (ENV['BOLETOSIMPLES_ENV'] || :sandbox).to_sym
      @application_id = ENV['BOLETOSIMPLES_APP_ID']
      @application_secret = ENV['BOLETOSIMPLES_APP_SECRET']
      @access_token = ENV['BOLETOSIMPLES_ACCESS_TOKEN']
    end

    def base_uri
      BASE_URI[@environment]
    end

    def user_agent
      "BoletoSimples Ruby Client v#{BoletoSimples::VERSION} (contato@boletosimples.com.br)"
    end

    def access_token?
      !@access_token.nil?
    end

    def client_credentials
      conn = Faraday.new(url: BoletoSimples.configuration.base_uri) do |c|
        # Request
        c.use BoletoSimples::Middleware::UserAgent
        c.use Faraday::Request::UrlEncoded

        # Response
        c.use Her::Middleware::DefaultParseJSON

        # Adapter
        c.use Faraday::Adapter::NetHttp
      end

      response = conn.post 'oauth2/token', {
        grant_type: 'client_credentials',
        client_id: application_id,
        client_secret: application_secret
      }
      response.body[:data]
    end

    def setup_her
      Her::API.setup url: BoletoSimples.configuration.base_uri do |c|
        # Request
        c.use BoletoSimples::Middleware::UserAgent
        c.use FaradayMiddleware::OAuth2, BoletoSimples.configuration.access_token if BoletoSimples.configuration.access_token?
        c.use Faraday::Request::UrlEncoded

        # Response
        c.use Her::Middleware::DefaultParseJSON

        # Adapter
        c.use Faraday::Adapter::NetHttp
      end

      # Because Her set the api on the moment module is included we need to call use_api again, after changing the configuration.
      [BankBillet, Customer, Transaction, Partner::User].each do |klass|
        klass.send(:use_api, Her::API.default_api)
      end
    end

  end

end