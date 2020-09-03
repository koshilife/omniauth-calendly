# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'simplecov'
SimpleCov.start
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
require 'minitest/autorun'
require 'webmock/minitest'

require 'omniauth-calendly'
require 'omniauth'
require 'rack/test'

class StrategyTest < Minitest::Test
  include OmniAuth::Test::StrategyTestCase
  include Rack::Test::Methods

  def setup
    # ENV['OAUTH_DEBUG'] = 'true'
    @logger = Logger.new STDOUT
    OmniAuth.config.logger = @logger
    @client_id = 'DUMMY_CLIENT_ID'
    @client_secret = 'DUMMY_CLIENT_SECRET'
    @options = {provider_ignores_state: true}
    @authorization_code = 'DUMMY_AUTH_CODE'
    @access_token = 'DUMMY_TOKEN'
    @refresh_token = 'DUMMY_REFRESH_TOKEN'
    @uid = 'DUMMY_CALENDLY_UID'
    @now = Time.new
  end

protected

  def strategy
    [OmniAuth::Strategies::Calendly, @client_id, @client_secret, @options]
  end

  def add_mock_exchange_token
    WebMock.enable!
    url = 'https://auth.calendly.com/oauth/token'
    body = {
      client_id: @client_id,
      client_secret: @client_secret,
      code: @authorization_code,
      grant_type: 'authorization_code',
      redirect_uri: 'http://example.org/auth/calendly/callback'
    }
    res_headers = {'Content-Type' => 'application/json'}
    stub_request(:post, url).with(body: URI.encode_www_form(body)).to_return(status: 200, body: dummy_token_response.to_json, headers: res_headers)
  end

  def dummy_token_response
    {
      token_type: 'Bearer',
      expires_in: 7200,
      created_at: @now.to_i,
      refresh_token: @refresh_token,
      access_token: @access_token,
      scope: 'default',
      owner: "https://api.calendly.com/users/#{@uid}"
    }
  end

  def add_mock_user_info
    WebMock.enable!
    url = "#{OmniAuth::Strategies::Calendly::USER_API_URL}me"
    headers = {'Authorization' => "Bearer #{@access_token}"}
    res_headers = {'Content-Type' => 'application/json'}
    stub_request(:get, url).with(headers: headers).to_return(status: 200, body: dummy_user_info_response.to_json, headers: res_headers)
  end

  def dummy_user_info_response
    {
      resource: {
        avatar_url: 'https://xxx.cloudfront.net/uploads/user/avatar/xxx/xxx.gif',
        created_at: '2020-07-17T05:36:18.596606Z',
        email: 'hoge@example.com',
        name: 'USER_NAME',
        scheduling_url: 'https://calendly.com/hogehoge',
        slug: 'hogehoge',
        timezone: 'Asia/Tokyo',
        updated_at: '2020-08-03T15:28:55.101449Z',
        uri: "https://api.calendly.com/users/#{@uid}"
      }
    }
  end
end
