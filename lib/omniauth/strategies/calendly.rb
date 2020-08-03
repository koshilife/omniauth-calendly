# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # OmniAuth strategy for Calendly
    class Calendly < OmniAuth::Strategies::OAuth2
      option :name, 'calendly'
      option :client_options, :site => 'https://auth.calendly.com'

      uid { raw_info['id'] }
      extra { {:raw_info => raw_info} }

    private

      def raw_info
        return @raw_info if defined?(@raw_info)

        endpoint = 'https://api.calendly.com/users/me'
        @raw_info = access_token.get(endpoint).parsed
      rescue ::OAuth2::Error => e
        log(:error, "#{e.class} occured. message:#{e.message}")
        @raw_info = {}
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
