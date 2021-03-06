# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # OmniAuth strategy for Calendly
    class Calendly < OmniAuth::Strategies::OAuth2
      option :name, 'calendly'
      option :client_options, site: 'https://auth.calendly.com'

      USER_API_URL = 'https://api.calendly.com/users/'

      uid { extract_uid }
      extra { {raw_info: raw_info} }

    private

      def raw_info
        return @raw_info if defined?(@raw_info)

        @raw_info = access_token.get("#{USER_API_URL}me").parsed
      end

      def extract_uid
        return unless raw_info.respond_to?(:dig)

        uri = raw_info.dig('resource', 'uri')
        return unless uri

        re = /\A#{USER_API_URL}(.+)\z/
        m = re.match uri
        return if m.nil?

        m[1]
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end
