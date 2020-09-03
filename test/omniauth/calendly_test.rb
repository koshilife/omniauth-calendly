# frozen_string_literal: true

require 'test_helper'

class StrategyCalendlyTest < StrategyTest
  def test_that_it_has_a_version_number
    refute_nil ::OmniAuth::Calendly::VERSION
  end

  def test_that_it_has_a_client_options
    args = [@client_id, @client_secret, @options]
    strat = OmniAuth::Strategies::Calendly.new(nil, *args)
    assert_equal(@client_id, strat.options[:client_id])
    assert_equal(@client_secret, strat.options[:client_secret])
    assert_equal('https://auth.calendly.com', strat.options[:client_options][:site])
  end

  def test_that_it_returns_auth_hash_in_callback_phase
    add_mock_exchange_token
    add_mock_user_info
    post '/auth/calendly/callback', code: @authorization_code, state: 'state123'

    actual_auth = auth_hash.to_hash
    assert(!actual_auth['credentials'].delete('expires_at').nil?)
    expected_auth = {
      'provider' => 'calendly',
      'uid' => @uid,
      'info' => {'name' => nil},
      'credentials' => {'token' => @access_token, 'refresh_token' => @refresh_token, 'expires' => true},
      'extra' => {
        'raw_info' => JSON.parse(dummy_user_info_response.to_json)
      }
    }
    assert_equal(expected_auth, actual_auth)
  end

private

  def auth_hash
    last_request.env['omniauth.auth']
  end
end
