require 'faraday'
require 'json'
require 'nubank/version'

HEADERS = {
  'Content-Type': 'application/json',
  'User-Agent': 'nubank-ruby (https://www.github.com/alfakini/nubank-ruby)',
  'Origin': 'https://conta.nubank.com.br',
  'Referer': 'https://conta.nubank.com.br',
}.freeze
NUBANK_URL = 'https://prod-s0-webapp-proxy.nubank.com.br'.freeze

class Nubank
  attr_reader :conn

  def initialize(cpf, password)
    @cpf = cpf
    @password = password
    @conn = Faraday.new(url: NUBANK_URL)
    services
  end

  def account
    JSON.parse(account_request.body)['account']
  end

  def bills_summary
    JSON.parse(bills_summary_request.body)['bills']
  end

  def events
    JSON.parse(events_request.body)['events']
  end

  def login
    @login ||= JSON.parse(login_request.body)
  end

  def logout
    logout_request
    @conn = nil
  end

  def services
    @services ||= JSON.parse(discovery_request.body)
  end

  def urls
    @login['_links']
  end

  private

  def account_request
    make_get_request(urls['account']['href'])
  end

  def bills_summary_request
    make_get_request(urls['bills_summary']['href'])
  end

  def discovery_request
    @conn.get do |request|
      request.url('/api/discovery')
      request.headers = HEADERS
    end
  end

  def events_request
    make_get_request(urls['events']['href'])
  end

  def login_request
    @conn.post do |request|
      request.url(services['login'])
      request.headers = HEADERS
      request.body = JSON.dump({
        grant_type: 'password',
        login: @cpf,
        password: @password,
        client_id: 'other.conta',
        client_secret: 'yQPeLzoHuJzlMMSAjC-LgNUJdUecx8XO'
      })
    end
  end

  def logout_request
    make_post_request(urls['revoke_token']['href'])
  end

  def auth_headers
    @auth_headers ||= begin
      access_token = login['access_token']
      HEADERS.merge('Authorization' => "Bearer #{access_token}")
    end
  end

  def make_get_request(url)
    @conn.get do |request|
      request.url(url)
      request.headers = auth_headers
    end
  end

  def make_post_request(url)
    @conn.post do |request|
      request.url(url)
      request.headers = auth_headers
    end
  end
end
