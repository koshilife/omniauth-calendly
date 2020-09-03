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

      def callback_url
        full_host + script_name + callback_path
      end

      def extract_uid
        user_info = raw_info
        return unless user_info
        return unless raw_info['resource']
        return unless raw_info['resource']['uri']

        uri = raw_info['resource']['uri']
        re = /\A#{USER_API_URL}(.+)\z/
        m = re.match uri
        return if m.nil?

        m[1]
      end
    end
  end
end
